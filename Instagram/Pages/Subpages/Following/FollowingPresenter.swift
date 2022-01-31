//
//  FollowingPresenter.swift
//  PostFeed
//
//  Created by Yersage on 11.11.2021.
//

import Foundation

final class FollowingPresenter: FollowingPresenterDelegate {
    
    private let paginationService = PaginationService()
    weak var view: FollowingViewDelegate?
    private let followingService = FollowingService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))

    private var userID: Int?
    
    init(userID: Int?) {
        self.userID = userID
    }
    
    func getFollowings(firstPage: Bool) {
        guard let userID = userID else { return }
        
        if paginationService.getIsPaginating() { return }
        paginationService.changeIsPaginating()
        
        if firstPage {
            paginationService.nullifyPage()
        }
        
        followingService.getFollowingList(by: userID) { result in
            switch result {
            case .success(let newFollowings):
                self.view?.removeSpinners()
                self.paginationService.changeIsPaginating()
                self.view?.set(followings: newFollowings)
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
    func unfollow() {}
}
