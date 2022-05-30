//
//  ConfirmationPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol ConfirmationPresenterDelegate: AnyObject {
    func nextButtonPressed(verificationCode: String)
    func viewDidLoad()
}
