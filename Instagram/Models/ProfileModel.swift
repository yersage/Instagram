//
//  ProfileModel.swift
//  PostFeed
//
//  Created by Yersage on 14.09.2021.
//

import Foundation

struct ProfileModel: Codable {
    let user: User
    let userMetaData: UserMetaData
}

struct User: Codable {
    let username: String
    let name: String?
    let id: Int
    let bio: String?
    let website: String?
    let numberOfFollowers: Int
    let numberOfFollowings: Int
    let numberOfPosts: Int
}

struct UserMetaData: Codable {
    let isFollowedByCurrentUser: Bool
}
