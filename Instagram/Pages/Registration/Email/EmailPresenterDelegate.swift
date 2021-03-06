//
//  EmailPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol EmailPresenterDelegate: AnyObject {
    func nextButtonPressed(email: String)
    func signInButtonPressed()
}
