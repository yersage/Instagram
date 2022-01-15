//
//  NetworkContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

protocol NetworkContext: AnyObject {
    var route: InstagramRoute { get }
    var method: NetworkMethod { get }
    var encoding: NetworkEncoding { get }
    var parameters: [String: Any] { get set }
}

extension NetworkContext {
    
    var url: URL? { return route.url() }
    
    var parameters: [String: Any] {
        get {
            return [:]
        } set {
            parameters = newValue
        }
    }
    
    var encoding: NetworkEncoding { return .url }
}
