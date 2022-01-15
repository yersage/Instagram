//
//  CreatePostPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 09.12.2021.
//

import UIKit

protocol CreatePostPresenterDelegate: AnyObject {
    func uploadPost(image: UIImage?, caption: String)
}
