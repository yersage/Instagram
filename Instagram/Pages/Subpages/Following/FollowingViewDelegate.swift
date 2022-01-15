//
//  FollowingViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 11.11.2021.
//

import Foundation

protocol FollowingViewDelegate: AnyObject {
    func set(followings: [ProfileModel])
    func removeSpinners()
    func refresh()
    func show(error: String)
}
