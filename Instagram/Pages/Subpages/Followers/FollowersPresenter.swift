//
//  FollowersPresenter.swift
//  PostFeed
//
//  Created by Yersage on 20.10.2021.
//

import UIKit

final class FollowersPresenter: FollowersPresenterDelegate {
    
    weak var view: FollowersViewDelegate?
    private let service = FollowersService()
    private let networkManager: NetworkManager = NetworkManager()
    
    func getFollowers(firstPage: Bool, userID: Int?) {
        guard let userID = userID else { return }
        
        if service.getIsPaginating() { return }
        service.changeIsPaginating()
        
        if firstPage {
            service.nullifyPage()
        }
        
        networkService.loadDecodable(endPoint: , type: [ProfileModel].self) { result in
            switch result {
            case .success(let newFollowers):
                self.view?.removeSpinners()
                self.service.changeIsPaginating()
                self.view?.set(followers: newFollowers)
                self.view?.refresh()
                self.service.increasePage()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
                self.view?.removeSpinners()
                self.service.changeIsPaginating()
            }
        }
    }
    
    func follow() {}
    func remove() {}
}
