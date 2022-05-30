//
//  PasswordPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol PasswordPresenterDelegate: AnyObject {
    func nextButtonPressed(password: String)
    func signup(authModel: AuthModel)
}
