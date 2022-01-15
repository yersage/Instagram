//
//  FeedPresenter.swift
//  PostFeed
//
//  Created by Yersage on 16.10.2021.
//

import UIKit
import Alamofire

class FeedPresenter: FeedPresenterDelegate {
    // MARK:- Initialization
    private let networkService: NetworkService = NetworkAdapter()
    private let feedService = FeedService()
    
    private let view: FeedViewDelegate
    
    init(view: FeedViewDelegate) {
        self.view = view
    }
    
    func downloadPosts(firstPage: Bool) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            self.feedService.nullifyPage()
        }
        
        let page = self.feedService.getPage()
        
        networkService.loadDecodable(context: FeedPostsContext(page: page), type: [PostModel].self) { result in
            switch result {
            case .success(let newPosts):
                self.view.removeSpinners()
                self.feedService.changeIsPaginating()
                self.view.set(newPosts: newPosts)
                self.view.reload()
                self.feedService.increasePage()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view.showError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func like(like: Bool, postID: Int, index: Int) {
        networkService.loadDecodable(context: PostLikeContext(postID: "\(postID)"), type: PostModel.self) { result in
            switch result {
            case .success(let newPost):
                self.view.setPost(post: newPost, index: index)
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view.showError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func unlike(like: Bool, postID: Int, index: Int) {
        networkService.loadDecodable(context: PostUnlikeContext(postID: "\(postID)"), type: PostModel.self) { result in
            switch result {
            case .success(let newPost):
                self.view.setPost(post: newPost, index: index)
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view.showError(error: error.localizedDescription)
                }
            }
        }
    }
}
