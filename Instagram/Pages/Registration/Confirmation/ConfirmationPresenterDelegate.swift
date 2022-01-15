//
//  ConfirmationPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol ConfirmationPresenterDelegate: AnyObject {
    func signup(email: String, password: String, username: String)
    func verify(email: String, verificationCode: String)
}
