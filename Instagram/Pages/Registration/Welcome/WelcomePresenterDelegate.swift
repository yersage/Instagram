//
//  WelcomePresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol WelcomePresenterDelegate: AnyObject {
    func login(username: String, password: String)
}
