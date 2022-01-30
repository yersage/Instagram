//
//  FeedPresenter.swift
//  PostFeed
//
//  Created by Yersage on 16.10.2021.
//

import UIKit

final class FeedPresenter: FeedPresenterDelegate {
    // MARK:- Initialization
    private let feedService = FeedService()
    private let postsService = PostsService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))
    
    weak var view: FeedViewDelegate?
    
    func downloadPosts(firstPage: Bool) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            self.feedService.nullifyPage()
        }
        
        let page = self.feedService.getPage()
        
        postsService.requestPosts(page: page) { result in
            switch result {
            case .success(let newPosts):
                self.view?.removeSpinners()
                self.feedService.changeIsPaginating()
                self.view?.set(newPosts: newPosts)
                self.view?.reload()
                self.feedService.increasePage()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.showError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func like(like: Bool, postID: Int, index: Int) {
        postsService.like(postID: "\(postID)") { result in
            switch result {
            case .success(let newPost):
                self.view?.setPost(post: newPost, index: index)
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.showError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func unlike(like: Bool, postID: Int, index: Int) {
        postsService.unlike(postID: "\(postID)") { result in
            switch result {
            case .success(let newPost):
                self.view?.setPost(post: newPost, index: index)
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.showError(error: error.localizedDescription)
                }
            }
        }
    }
}
