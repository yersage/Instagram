//
//  ProfileViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 09.11.2021.
//

import Foundation

protocol ProfileViewDelegate {
    func set(posts: [PostModel])
    func set(profileModel: ProfileModel)
    func setupProfileData()
    func show(error: String)
    func reload()
}
