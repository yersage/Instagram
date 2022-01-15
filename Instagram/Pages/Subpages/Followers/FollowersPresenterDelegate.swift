//
//  FollowersPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 09.11.2021.
//

import Foundation

protocol FollowersPresenterDelegate: AnyObject {
    func getFollowers(firstPage: Bool, userID: Int?)
    func follow()
    func remove()
}
