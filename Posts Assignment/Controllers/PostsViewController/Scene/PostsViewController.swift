//
//  PostsViewController.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import UIKit

final class PostsViewController: BaseViewController {
    
    static var storyBoardId: String = ViewControllerId.postsViewController
    static var storyBoardName: String = Storyboard.main
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: PostsViewModelProtocol?
    private let indicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        indicator.center = footerView.center
        footerView.addSubview(indicator)
        tableView.tableFooterView = footerView
        
        tableView.register(cellClass: PostTableViewCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        viewModel?.fetchData()
    }
}

extension PostsViewController: PostsViewModelOutputProtocol {
    func reloadData(indexPaths: [IndexPath]) {
        tableView.insertRows(at: indexPaths, with: .none)
    }
    
    func showHideLoading() {
        guard let isLoading = viewModel?.isLoading, isLoading else {
            indicator.isHidden = true
            indicator.stopAnimating()
            return
        }
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func showError(message: String) {
        showAlert(message: message)
    }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel else { return UITableViewCell() }
        let cell: PostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(viewModel: viewModel.item(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.loadMorePosts(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel else { return }
        let controller = DetailViewController.instantiateFromStoryBoard()
        controller.viewModel = DetailViewModel(model: viewModel.didSelectItem(at: indexPath))
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true)
    }
}
