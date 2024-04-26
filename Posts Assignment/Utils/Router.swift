//
//  Router.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import Foundation

enum Router {
    
    case posts(Int, Int)
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var httpMethod: String {
        switch self {
        case .posts:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .posts(let page, let limit):
            return ["_page": page, "_limit": limit]
        }
    }

    func asURLRequest() -> URLRequest {
        var url = baseURL.appendingPathComponent(self.path)
        if httpMethod == "GET", let parameters = parameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components.queryItems = queryItems
            url = components.url!
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        return request
    }

}
