//
//  SelfProfileViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import Foundation

protocol SelfProfileViewDelegate: AnyObject {
    func set(posts: [PostModel])
    func set(profileModel: ProfileModel)
    func setupProfileData()
    func show(error: String)
    func refresh()
    func enableEditProfileButton()
}
