//
//  SelfProfilePresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import Foundation

protocol SelfProfilePresenterDelegate: AnyObject {
    func getPosts(firstPage: Bool, userID: String)
    func getProfileData(userID: Int)
}
