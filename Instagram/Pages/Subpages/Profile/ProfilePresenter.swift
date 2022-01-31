//
//  ProfilePresenter.swift
//  PostFeed
//
//  Created by Yersage on 09.11.2021.
//

import Foundation

final class ProfilePresenter: ProfilePresenterDelegate {
    
    weak var view: ProfileViewDelegate?
    private let feedService = FeedService()
    private let profileService = ProfileService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))
    
    func getPosts(firstPage: Bool, userID: String) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            feedService.nullifyPage()
        }
        
        let page = feedService.getPage()
        
        profileService.getProfilePosts(userID: userID, page: page) { result in
            switch result {
            case .success(let newPosts):
                self.feedService.changeIsPaginating()
                self.view?.set(posts: newPosts)
                self.feedService.increasePage()
                self.view?.reload()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getProfileData(userID: Int) {
        profileService.getProfileData(userID: userID) { result in
            switch result {
            case .success(let profileModel):
                self.view?.set(profileModel: profileModel)
                self.view?.setupProfileData()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    func follow(userID: Int?) {
        guard let userID = userID else { self.view?.show(error: NetworkError.noData.description); return }
        
        profileService.follow(userID: "\(userID)") { result in
            switch result {
            case .success(let profileModel):
                self.view?.set(profileModel: profileModel)
                self.view?.setupProfileData()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
    
    func unfollow(userID: Int?) {
        guard let userID = userID else { self.view?.show(error: NetworkError.noData.description); return }
        
        profileService.unfollow(userID: "\(userID)") { result in
            switch result {
            case .success(let profileModel):
                self.view?.set(profileModel: profileModel)
                self.view?.setupProfileData()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
