//
//  FollowingPresenter.swift
//  PostFeed
//
//  Created by Yersage on 11.11.2021.
//

import Foundation

class FollowingPresenter: FollowingPresenterDelegate {
    
    private let networkService: NetworkService = NetworkAdapter()
    private let service = FollowingService()
    private var view: FollowingViewDelegate?
    
    private var userID: Int?
    
    init(view: FollowingViewDelegate, userID: Int?) {
        self.view = view
        self.userID = userID
    }
    
    func getFollowings(firstPage: Bool) {
        if userID == nil { return }
        
        if service.getIsPaginating() { return }
        service.changeIsPaginating()
        
        if firstPage {
            service.nullifyPage()
        }
                
        networkService.loadDecodable(context: FollowingEndPoint(userID: userID!), type: [ProfileModel].self) { result in
            switch result {
            case .success(let newFollowings):
                self.view?.removeSpinners()
                self.service.changeIsPaginating()
                self.view?.set(followings: newFollowings)
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
    func unfollow() {}
}
