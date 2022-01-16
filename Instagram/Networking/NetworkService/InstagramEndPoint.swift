//
//  InstagramEndPoint.swift
//  PostFeed
//
//  Created by Yersage on 25.10.2021.
//

import Foundation
/*
public enum InstagramAPI {
    case followers(page: Int)
    case posts(page: Int)
}

extension InstagramAPI: Endpoint {
    var baseURL: URL {
        guard let url = URL(string: "http:\\192.168.0.246") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .followers(let page):
            return "posts/followers"
        case .posts(let page):
            return "posts"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .followers(let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page,
                                                                           "api_key": NetworkManager.InstagramAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
*/

