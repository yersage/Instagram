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
    private let networkManager: NetworkManager = NetworkManager()
    private let keychain = KeychainSwift()

    func login(username: String, password: String) {
        networkManager.request(InstagramEndPoint.login(username: username, password: password)) { [self] (result: Result<TokenModel, Error>) -> Void in
            switch result {
            case .success(let tokenModel):
                keychain.set(tokenModel.accessToken, forKey: K.keychainAccessTokenKey)
                keychain.set(tokenModel.refreshToken, forKey: K.keychainRefreshTokenKey)
                self.view?.goToFeedVC()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
