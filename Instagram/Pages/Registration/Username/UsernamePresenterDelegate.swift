//
//  UsernamePresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol UsernamePresenterDelegate: AnyObject {
    func isUsernameAcceptable(username: String)
}
