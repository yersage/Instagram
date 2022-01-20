//
//  PostFeedModel.swift
//  PostFeed
//
//  Created by Yersage on 10.09.2021.
//

import Foundation

struct PostModel: Codable {
    let post: Post
    let postMetaData: PostMetaData
}

struct Post: Codable {
    var caption: String
    var created: String
    var id: Int
    var numberOfComments: Int
    var numberOfImages: Int
    var numberOfLikes: Int
    var user: UserProjection
}

struct UserProjection: Codable {
    let id: Int
    let username: String
}

struct PostMetaData: Codable {
    var isPostLikedByCurrentUser: Bool
}
