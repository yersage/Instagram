//
//  WelcomePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation
import KeychainSwift

final class WelcomePresenter: WelcomePresenterDelegate {
    weak var view: WelcomeViewDelegate?
    private let keychainService: KeychainServiceDelegate = KeychainService()
    private let userIDFetchService: UserIDFetchable = JWTDecoder()
    private let authService = AuthService()

    func login(username: String, password: String) {
        authService.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let tokenModel):
                self?.keychainService.set(tokenModel.accessToken, forKey: K.keychainAccessTokenKey)
                self?.keychainService.set(tokenModel.refreshToken, forKey: K.keychainRefreshTokenKey)
                if let userID = self?.userIDFetchService.fetchUserID(from: tokenModel.accessToken) {
                    self?.keychainService.set(userID, forKey: K.keychainUserIDKey)

                }
                self?.view?.goToFeedVC()
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
    }
}
