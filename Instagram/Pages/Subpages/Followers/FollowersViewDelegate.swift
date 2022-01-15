//
//  FollowersViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 20.10.2021.
//

import Foundation

protocol FollowersViewDelegate: AnyObject {
    func set(followers: [ProfileModel])
    func show(error: String)
    func removeSpinners()
    func refresh()
}
