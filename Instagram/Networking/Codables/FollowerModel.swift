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
    var id: Int = 0
    var bio: String?
    var website: String?
    var username: String = ""
    var numberOfPosts: Int = 0
    var numberOfFollowers: Int = 0
    var numberOfFollowings: Int = 0
}

struct FollowerMetaData: Codable {
    var isFollowedByCurrentUser: Bool = false
}
