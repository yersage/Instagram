//
//  SelfProfilePresenter.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import Foundation

final class SelfProfilePresenter: SelfProfilePresenterDelegate {
    private let networkService: NetworkService = NetworkAdapter()
    weak var view: SelfProfileViewDelegate?
    private let feedService = FeedService()
    
    func getPosts(firstPage: Bool, userID: String) {
        
        if feedService.getIsPaginating() { return }
        feedService.changeIsPaginating()
        
        if firstPage == true {
            feedService.nullifyPage()
        }
        
        networkService.loadDecodable(endPoint: ProfilePostsEndPoint(userID: userID, page: feedService.getPage()), type: [PostModel].self) { result in
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
        networkService.loadDecodable(context: ProfileDataEndPoint(userID: userID), type: ProfileModel.self) { result in
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
