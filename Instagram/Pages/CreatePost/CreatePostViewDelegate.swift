//
//  CreatePostViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 09.12.2021.
//

import Foundation

protocol CreatePostViewDelegate: AnyObject {
    func show(error: String)
    func showSuccess()
    func goToFeedVC()
}
