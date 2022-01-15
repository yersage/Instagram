//
//  FollowersPresenter.swift
//  PostFeed
//
//  Created by Yersage on 20.10.2021.
//

import UIKit

final class FollowersPresenter: FollowersPresenterDelegate {
    
    private let networkService: NetworkService = NetworkAdapter()
    weak private var view: FollowersViewDelegate?
    private let service = FollowersService()
        
    init(view: FollowersViewDelegate) {
        self.view = view
    }
    
    func getFollowers(firstPage: Bool, userID: Int?) {
        if userID == nil { return }
        
        if service.getIsPaginating() { return }
        service.changeIsPaginating()
        
        if firstPage {
            service.nullifyPage()
        }
        
        networkService.loadDecodable(context: FollowerContext(userID: userID!), type: [ProfileModel].self) { result in
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
