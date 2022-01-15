//
//  ProfileContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class EditProfileContext: NetworkContext {
    var route: InstagramRoute { return .editProfile }
    var method: NetworkMethod { return .put }
    var parameters = [String: Any]()
    
    init(name: String?, website: String?, bio: String?, username: String) {
        if name != nil {
            parameters["name"] = name
        }
        if website != nil {
            parameters["website"] = website
        }
        if bio != nil {
            parameters["bio"] = bio
        }
        parameters["username"] = username
    }
}

class ProfileDataContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(userID: Int) {
        route = .profileData(userID: userID)
    }
}

class ProfileImageContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(userID: String) {
        route = .profileImage(userID: userID)
    }
}

class ProfilePostsContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(userID: String, page: Int) {
        route = .profilePosts(userID: userID, page: page)
    }
}

class ProfilePostImagesContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(postID: String) {
        route = .postImages(postID: postID)
    }
}

class FollowContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    let parameters = [String : Any]()
    
    init(userID: String) {
        route = .follow(userID: userID)
    }
}

class UnfollowContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    let parameters = [String : Any]()
    
    init(userID: String) {
        route = .unfollow(userID: userID)
    }
}
