//
//  FeedContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class FeedPostsContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(page: Int) {
        route = .feedPosts(page: page)
    }
}

class FeedPostImagesContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(postID: Int) {
        route = .feedPostImages(postID: postID)
    }
}

class PostUnlikeContext: NetworkContext {
    var route: InstagramRoute
    var method: NetworkMethod { return .get }
    var parameters = [String: Any]()
    
    init(postID: String) {
        route = InstagramRoute.postUnlike(postID: postID)
    }
}

class PostLikeContext: NetworkContext {
    var route: InstagramRoute
    var method: NetworkMethod { return .get }
    var parameters = [String: Any]()
    
    init(postID: String) {
        route = InstagramRoute.postLike(postID: postID)
    }
}
