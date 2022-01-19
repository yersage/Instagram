//
//  WelcomeViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol WelcomeViewDelegate: AnyObject {
    func show(error: String)
    func goToFeedVC()
}
