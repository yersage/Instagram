//
//  SignInPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation
import KeychainSwift

final class SignInPresenter: SignInPresenterDelegate {
    weak var view: SignInViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()
    private let keychain = KeychainSwift()
    
    func login(username: String, password: String) {
        
        if username == "" || password == "" {
            self.view?.show(error: "Username or password is not provided.")
        }
        
        networkManager.noInterceptorRequest(InstagramEndPoint.login(username: username, password: password)) { [self] (result: Result<TokenModel, Error>) -> Void in
            switch result {
            case .success(let tokenModel):
                keychain.set(tokenModel.accessToken, forKey: K.keychainAccessTokenKey)
                keychain.set(tokenModel.refreshToken, forKey: K.keychainRefreshTokenKey)
                keychain.set(username, forKey: K.keychainUsernameKey)
                keychain.set(password, forKey: K.keychainPasswordKey)
                self.view?.goToFeedVC()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
