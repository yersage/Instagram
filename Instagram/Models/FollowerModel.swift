//
//  FollowerModel.swift
//  PostFeed
//
//  Created by Yersage on 28.09.2021.
//

import Foundation

struct FollowerModel: Codable {
    let userProjection: FollowerProjection
    let userMetaData: FollowerMetaData
}

struct FollowerProjection: Codable {
    var name: String?
    var id: Int
    var bio: String?
    var website: String?
    var username: String
    var numberOfPosts: Int
    var numberOfFollowers: Int
    var numberOfFollowings: Int
}

struct FollowerMetaData: Codable {
    var isFollowedByCurrentUser: Bool = false
}
