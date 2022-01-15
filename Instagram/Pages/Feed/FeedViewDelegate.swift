//
//  FeedViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 16.10.2021.
//

import UIKit

protocol FeedViewDelegate: NSObjectProtocol {    
    func set(newPosts: [PostModel])
    func removeSpinners()
    func setPost(post: PostModel, index: Int)
    func showError(error: String)
    func reload()
}
