//
//  SelfProfilePresenter.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import Foundation

final class SelfProfilePresenter: SelfProfilePresenterDelegate {
    weak var view: SelfProfileViewDelegate?
    private let feedService = FeedService()
    private let networkManager: NetworkManager = NetworkManager()
    
    func getPosts(firstPage: Bool, userID: String) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            feedService.nullifyPage()
        }
        
        let page = feedService.getPage()
        
        networkManager.request(InstagramEndPoint.profilePosts(userID: userID, page: page)) { (result: Result<[PostModel], Error>) -> Void in
            switch result {
            case .success(let newPosts):
                self.feedService.changeIsPaginating()
                self.view?.set(posts: newPosts)
                self.feedService.increasePage()
                self.view?.refresh()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getProfileData(userID: Int) {
        networkManager.request(InstagramEndPoint.profileData(userID: userID)) { (result: Result<ProfileModel, Error>) -> Void in
            switch result {
            case .success(let profileModel):
                self.view?.set(profileModel: profileModel)
                self.view?.setupProfileData()
                self.view?.enableEditProfileButton()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
}
