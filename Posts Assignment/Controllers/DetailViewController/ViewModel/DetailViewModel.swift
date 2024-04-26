//
//  DetailViewModel.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import Foundation

protocol DetailViewModelProtocol {
    init(model: PostData)
    var title: String? { get }
    var body: String? { get }
}

class DetailViewModel: DetailViewModelProtocol {
    
    private let model: PostData
    
    required init(model: PostData) {
        self.model = model
    }
    
    var title: String? {
        model.title
    }
    
    var body: String? {
        model.body
    }
}
