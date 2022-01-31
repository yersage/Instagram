//
//  FollowersPresenter.swift
//  PostFeed
//
//  Created by Yersage on 20.10.2021.
//

import UIKit

final class FollowersPresenter: FollowersPresenterDelegate {
    
    weak var view: FollowersViewDelegate?
    private let paginationService = PaginationService()
    private let followersService = FollowersService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))
    
    func getFollowers(firstPage: Bool, userID: Int?) {
        guard let userID = userID else { return }
        
        if paginationService.getIsPaginating() { return }
        paginationService.changeIsPaginating()
        
        if firstPage {
            paginationService.nullifyPage()
        }
        
        followersService.getFollowersList(by: userID) { result in
            switch result {
            case .success(let newFollowers):
                self.view?.removeSpinners()
                self.paginationService.changeIsPaginating()
                self.view?.set(followers: newFollowers)
                self.view?.refresh()
                self.paginationService.increasePage()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
                self.view?.removeSpinners()
                self.paginationService.changeIsPaginating()
            }
        }
    }
    
    func follow() {}
    func remove() {}
}
