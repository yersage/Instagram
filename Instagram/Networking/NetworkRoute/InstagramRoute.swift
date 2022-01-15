//
//  InstagramRoute.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

enum InstagramRoute {
    
    case signIn
    case refreshToken
    
    case emailAvailability(email: String)
    case usernameAvailability(username: String)
    case signUp
    case accountVerification
    
    case feedPosts(page: Int)
    case feedPostImages(postID: Int)
    
    case search(name: String)
    
    case uploadPost
    
    case editProfile
    
    case profileData(userID: Int)
    case profileImage(userID: String)
    case profilePosts(userID: String, page: Int)
    case postImages(postID: String)
    
    case postUnlike(postID: String)
    case postLike(postID:String)
    
    case commentUnlike
    case commentLike
    
    case comments(page: Int, postID: Int)
    case showCommentReplies(commentID: Int, page: Int)
    case postComment
    
    case follow(userID: String)
    case unfollow(userID: String)
    
    case followersList(userID: Int)
    case followingList(userID: Int)
    
    private func getRoute() -> String {
        switch self {
        case .signIn:
            return "auth/login"
        case .refreshToken:
            return "auth/refresh-token"
        
        case .emailAvailability(let email):
            return "auth/email-available?email=\(email)"
        case .usernameAvailability(let username):
            return "auth/username-available?username=\(username)"
        case .signUp:
            return "auth/signup"
        case .accountVerification:
            return "auth/account-verification"
        
        case .feedPosts(let page):
            return "post/feed?page=\(page)"
        case .feedPostImages(let postID):
            return "post/\(postID)/1"
            
        case .search(let name):
            return "user/search?name=\(name)"
        
        case .uploadPost:
            return "post"
        
        case .editProfile:
            return "user"
        
        case .profileData(let userID):
            return "user?userId=\(userID)"
        case .profileImage(let userID):
            return "user/image?userId=\(userID)"
        case .profilePosts(let userID, let page):
            return "post/profile?userId=\(userID)&page=\(page)"
        case .postImages(let postID):
            return "post/image?imageId=0&postId=\(postID)"
        
        case .postUnlike(let postID):
            return "post/unlike?postId=\(postID)"
        case .postLike(let postID):
            return "post/like?postId=\(postID)"
        
        case .commentUnlike:
            return "comment/unlike"
        case .commentLike:
            return "comment/like"
        
        case .comments(let page, let postID):
            return "comment?page=\(page)&postId=\(postID)"
        case .showCommentReplies(let commentID, let page):
            return "comment/children?commentId=\(commentID)&page=\(page)"
        case .postComment:
            return "comment"
            
        case .follow(let userID):
            return "user/follow?userId=\(userID)"
        case .unfollow(let userID):
            return "user/unfollow?userId=\(userID)"
            
        case .followersList(let userID):
            return "user/followers-list?userId=\(userID)"
        case .followingList(let userID):
            return "user/followings-list?userId=\(userID)"
        }
    }
}

extension InstagramRoute {
    func url() -> URL? {
        return URL(string: InstagramAPI.baseURLString + getRoute())
    }
    
    func urlString() -> String {
        return InstagramAPI.baseURLString + getRoute()
    }
}
