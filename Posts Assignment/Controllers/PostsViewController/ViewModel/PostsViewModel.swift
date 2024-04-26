//
//  PostsViewModel.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import Foundation

protocol PostsViewModelProtocol {
    init(delegate: PostsViewModelOutputProtocol,
         service: PostsServiceProtocol)
    func fetchData()
    func numberOfRows() -> Int
    func item(at indexPath: IndexPath) -> PostCellViewModelProtocol?
    func didSelectItem(at indexPath: IndexPath) -> PostData
    func loadMorePosts(indexPath: IndexPath)
    var isLoading: Bool { get }
}

protocol PostsViewModelOutputProtocol: AnyObject {
    func reloadData(indexPaths: [IndexPath])
    func showHideLoading()
    func showError(message: String)
}

final class PostsViewModel: PostsViewModelProtocol {
    
    private weak var delegate: PostsViewModelOutputProtocol?
    private let service: PostsServiceProtocol
    private var posts = [PostData]()
    private var page: Int = 1
    private var limit: Int = 25
    private var hasMoreData: Bool = true
    var isLoading: Bool = false

    required init(delegate: PostsViewModelOutputProtocol,
                  service: PostsServiceProtocol) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        delegate?.showHideLoading()
        Task {
            do {
                let model = try await service.getPosts(router: .posts(page, limit))
                if let error = model.error {
                    isLoading = false
                    await MainActor.run {
                        delegate?.showHideLoading()
                        delegate?.showError(message: error)
                    }
                } else {
                    isLoading = false
                    let oldCount = self.posts.count
                    self.hasMoreData = model.posts.count == self.limit
                    self.posts.append(contentsOf: model.posts)
                    await MainActor.run {
                        var indexPaths = [IndexPath]()
                        for i in oldCount..<posts.count {
                            indexPaths.append(IndexPath(item: i, section: 0))
                        }
                        delegate?.reloadData(indexPaths: indexPaths)
                        delegate?.showHideLoading()
                    }
                }
            } catch {
                isLoading = false
                delegate?.showHideLoading()
                delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return posts.count
    }
    
    func item(at indexPath: IndexPath) -> PostCellViewModelProtocol? {
        return PostCellViewModel(post: posts[indexPath.row])
    }
    
    func didSelectItem(at indexPath: IndexPath) -> PostData {
        posts[indexPath.row]
    }
    
    func loadMorePosts(indexPath: IndexPath) {
        if indexPath.row == posts.count - 1, hasMoreData {
            page += 1
            fetchData()
        }
    }
}
