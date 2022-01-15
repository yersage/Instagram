//
//  ProfilePresenter.swift
//  PostFeed
//
//  Created by Yersage on 09.11.2021.
//

import Foundation

class ProfilePresenter: ProfilePresenterDelegate {
    
    private let networkService: NetworkService = NetworkAdapter()
    private let view: ProfileViewDelegate?
    private let feedService = FeedService()
    
    init(view: ProfileViewDelegate) {
        self.view = view
    }
    
    func getPosts(firstPage: Bool, userID: String) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            feedService.nullifyPage()
        }
        
        networkService.loadDecodable(context: ProfilePostsContext(userID: userID, page: feedService.getPage()), type: [PostModel].self) { result in
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
        networkService.loadDecodable(context: ProfileDataContext(userID: userID), type: ProfileModel.self) { result in
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
        
        networkService.loadDecodable(context: FollowContext(userID: "\(userID)"), type: ProfileModel.self) { result in
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

        networkService.loadDecodable(context: UnfollowContext(userID: "\(userID)"), type: ProfileModel.self) { result in
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
