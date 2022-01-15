//
//  FeedPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 06.11.2021.
//

import Foundation

protocol FeedPresenterDelegate: AnyObject {
    func downloadPosts(firstPage: Bool)
    func like(like: Bool, postID: Int, index: Int)
    func unlike(like: Bool, postID: Int, index: Int)
}
