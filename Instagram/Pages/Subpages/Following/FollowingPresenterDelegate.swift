//
//  FollowingPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 11.11.2021.
//

import Foundation

protocol FollowingPresenterDelegate: AnyObject {
    func getFollowings(firstPage: Bool)
    func follow()
    func unfollow()
}
