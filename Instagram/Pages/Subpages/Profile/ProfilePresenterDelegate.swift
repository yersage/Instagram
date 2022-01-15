//
//  ProfilePresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 09.11.2021.
//

import Foundation

protocol ProfilePresenterDelegate {
    func getPosts(firstPage: Bool, userID: String)
    func getProfileData(userID: Int)
    func follow(userID: Int?)
    func unfollow(userID: Int?)
}
