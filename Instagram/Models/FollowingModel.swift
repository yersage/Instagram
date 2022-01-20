//
//  FollowingModel.swift
//  PostFeed
//
//  Created by Yersage on 28.09.2021.
//

import Foundation

struct FollowingModel: Codable {
    let userProjection: FollowingProjection
    let userMetaData: FollowingMetaData
}

struct FollowingProjection: Codable {
    var name: String?
    var id: Int
    var bio: String?
    var website: String?
    var username: String
    var numberOfPosts: Int
    var numberOfFollowers: Int
    var numberOfFollowings: Int
}

struct FollowingMetaData: Codable {
    var isFollowedByCurrentUser: Bool
}
