//
//  PostsService.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import Foundation

typealias PostsResponse = (posts: [PostData], error: String?)
protocol PostsServiceProtocol {
    func getPosts(router: Router) async throws -> PostsResponse
}

struct PostsService: PostsServiceProtocol {
    func getPosts(router: Router) async throws -> PostsResponse {
        let request = router.asURLRequest()
        let (data, _) = try await URLSession.shared.data(for: request)
        do {
            let model = try JSONDecoder().decode([PostData].self, from: data)
            return (model, nil)
        } catch {
            if let error = String(data: data, encoding: .utf8) {
                return ([], error)
            } else {
                return ([], error.localizedDescription)
            }
        }
    }
}
