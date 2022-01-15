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
    var id: Int = 0
    var bio: String?
    var website: String?
    var username: String = ""
    var numberOfPosts: Int = 1
    var numberOfFollowers: Int = 1
    var numberOfFollowings: Int = 1
}

struct FollowingMetaData: Codable {
    var isFollowedByCurrentUser: Bool = false
}
