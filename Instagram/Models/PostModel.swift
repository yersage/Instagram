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
    var caption: String = ""
    var created: String = ""
    var id: Int = 0
    var numberOfComments: Int = 0
    var numberOfImages: Int = 1
    var numberOfLikes: Int = 0
    var user: UserProjection
}

struct UserProjection: Codable {
    let id: Int
    let username: String
}

struct PostMetaData: Codable {
    var isPostLikedByCurrentUser: Bool = false
}
