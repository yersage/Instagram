//
//  SearchContext.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import Foundation

class SearchContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(name: String) {
        route = .search(name: name)
    }
}
