//
//  FeedPresenter.swift
//  PostFeed
//
//  Created by Yersage on 16.10.2021.
//

import UIKit
import Alamofire

final class FeedPresenter: FeedPresenterDelegate {
    // MARK:- Initialization
    private let feedService = FeedService()
    private let postsService = PostsService()
    //private let interceptor: RequestInterceptorDelegate = KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: <#T##TokenServiceDelegate#>)
    
    weak var view: FeedViewDelegate?
    
    func downloadPosts(firstPage: Bool) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            self.feedService.nullifyPage()
        }
        
        let page = self.feedService.getPage()
        
        postsService.requestPosts(page: page, interceptor: <#T##RequestInterceptorDelegate#>, completion: <#T##(Result<[PostModel], Error>) -> ()#>)
        
        networkManager.request(InstagramEndPoint.feedPosts(page: page)) { (result: Result<[PostModel], Error>) -> Void in
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
        networkManager.request(InstagramEndPoint.postLike(postID: "\(postID)")) { (result: Result<PostModel, Error>) -> Void in
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
        networkManager.request(InstagramEndPoint.postUnlike(postID: "\(postID)")) { (result: Result<PostModel, Error>) -> Void in
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
