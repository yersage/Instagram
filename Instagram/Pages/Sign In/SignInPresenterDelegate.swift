//
//  SignInPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol SignInPresenterDelegate: AnyObject {
    func loginButtonPressed(username: String, password: String)
    func signUpButtonPressed()
}
