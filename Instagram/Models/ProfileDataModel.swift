//
//  ProfileDataModel.swift
//  PostFeed
//
//  Created by Yersage on 10.01.2022.
//

import Foundation

struct ProfileDataModel: Codable {
    let image: Data
    let name: Data?
    let bio: Data?
    let website: Data?
    let username: Data
}
