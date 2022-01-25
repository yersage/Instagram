//
//  InstagramRoute.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation
import Alamofire

public enum InstagramEndPoint {
    case login(username: String, password: String)
    case refreshToken(refreshToken: String)
    case emailAvailability(email: String)
    case usernameAvailability(username: String)
    case signUp(username: String, password: String, email: String)
    case accountVerification(confirmationCode: String, email: String)
    case feedPosts(page: Int)
    case search(name: String)
    case uploadPost(caption: Data, images: Data)
    case profileData(userID: Int)
    case profilePosts(userID: String, page: Int)
    case editProfile(image: Data, name: Data?, website: Data?, bio: Data?, username: Data)
    case postUnlike(postID: String)
    case postLike(postID:String)
    case commentUnlike(commentID: Int)
    case commentLike(commentID: Int)
    case comments(page: Int, postID: Int)
    case showCommentReplies(commentID: Int, page: Int)
    case postComment(commentIDRepliedTo: Int, content: String, postID: Int)
    case follow(userID: String)
    case unfollow(userID: String)
    case followersList(userID: Int)
    case followingList(userID: Int)
    case profileImage(userID: Int)
    case postImage(postID: Int)
}

extension InstagramEndPoint: EndPointType {
    
    var baseURL : String {
        return "http://localhost:8090/"
        /*
        switch NetworkManager.environment {
        case .production: return "http://localhost:8090/"
        case .qa: return "http://localhost:8090/"
        case .staging: return "http://localhost:8090/"
        }
         */
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .refreshToken(let refreshToken):
            return "auth/refresh-token?token=\(refreshToken)"
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
        case .search(let name):
            return "user/search?name=\(name)"
        case .uploadPost:
            return "post"
        case .editProfile:
            return "user"
        case .profileData(let userID):
            return "user?userId=\(userID)"
        case .profilePosts(let userID, let page):
            return "post/profile?userId=\(userID)&page=\(page)"
        case .postUnlike(let postID):
            return "post/unlike?postId=\(postID)"
        case .postLike(let postID):
            return "post/like?postId=\(postID)"
        case .commentUnlike(let commentID):
            return "comment/unlike?commentId=\(commentID)"
        case .commentLike(let commentID):
            return "comment/like?commentId=\(commentID)"
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
        case .profileImage(let userID):
            return "user/image?userId=\(userID)"
        case .postImage(let postID):
            return "post/image?postId=\(postID)&imageId=0"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .feedPosts, .postLike, .postUnlike, .profileData, .profilePosts, .follow, .unfollow, .comments, .showCommentReplies, .commentLike, .commentUnlike, .followersList, .followingList, .search, .postImage, .profileImage:
            return .get
        case .emailAvailability, .usernameAvailability, .signUp, .accountVerification, .uploadPost, .postComment, .login, .refreshToken:
            return .post
        case .editProfile:
            return .put
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let username, let password):
            return ["username": username,
                    "password": password]
        case .signUp(let username, let password, let email):
            return ["username": username,
                    "password": password,
                    "email": email]
        case .accountVerification(let confirmationCode, let email):
            return ["verificationCode": confirmationCode,
                   "email": email]
        case .postComment(let commentIDRepliedTo, let content, let postID):
            return ["commentIdRepliedTo": commentIDRepliedTo,
                    "content": content,
                    "postId": postID]
        default:
            return nil
        }
    }
    
    var formDataParts: [FormData]? {
        switch self {
        case .editProfile(let image, let name, let website, let bio, let username):
            var requestBody: [FormData] = []
            requestBody.append(FormData(data: image, withName: "image", fileName: "profileimage.png", mimeType: "image/png"))
            if let name = name {
                requestBody.append(FormData(data: name, withName: "name"))
            }
            if let bio = bio {
                requestBody.append(FormData(data: bio, withName: "bio"))
            }
            if let website = website {
                requestBody.append(FormData(data: website, withName: "website"))
            }
            requestBody.append(FormData(data: username, withName: "username"))
            return requestBody
        case .uploadPost(let caption, let images):
            var requestBody: [FormData] = []
            requestBody.append(FormData(data: caption, withName: "caption"))
            requestBody.append(FormData(data: images, withName: "images", fileName: "postimage.png", mimeType: "image/png"))
            return requestBody
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .signUp, .login:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}
