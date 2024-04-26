//
//  PostCellViewModel.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import Foundation

protocol PostCellViewModelProtocol {
    init(post: PostData)
    var id: String { get }
    var title: String { get }
}

final class PostCellViewModel: PostCellViewModelProtocol {
    
    private let post: PostData
    required init(post: PostData) {
        self.post = post
    }
    
    var id: String { 
        "\(post.id ?? 0)"
    }
    var title: String {
        post.title ?? ""
    }
}
