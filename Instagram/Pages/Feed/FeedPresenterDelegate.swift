//
//  FeedPresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 06.11.2021.
//

import Foundation

protocol FeedPresenterDelegate: AnyObject {
    var dataSource: FeedTableViewDataSource { get set }
    
    func viewDidLoad()
    
    func loaderStarted(from position: LoaderPosition)
    
    func downloadPosts(firstPage: Bool)
    func like(like: Bool, postID: Int, index: Int)
    func unlike(like: Bool, postID: Int, index: Int)
    
    func numberOfRowsInSection() -> Int
    func getPost(at index: Int) -> PostModel
}

enum LoaderPosition {
    case top
    case bottom
}
