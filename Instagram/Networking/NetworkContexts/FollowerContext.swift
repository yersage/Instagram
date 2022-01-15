//
//  FollowerContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class FollowerContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(userID: Int) {
        route = .followersList(userID: userID)
    }
}
