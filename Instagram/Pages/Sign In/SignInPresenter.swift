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
    private let keychainService: KeychainServiceDelegate = KeychainSwiftService(decoder: JWTDecoder())
    private let authService = AuthService()
    
    func login(username: String, password: String) {
        
        if username == "" || password == "" {
            self.view?.show(error: "Username or password is not provided.")
        }
        
        authService.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let tokenModel):
                self?.keychainService.set(tokenModel.accessToken, forKey: K.keychainAccessTokenKey)
                self?.keychainService.set(tokenModel.refreshToken, forKey: K.keychainRefreshTokenKey)
                if let userID = self?.keychainService.fetchUserID(from: tokenModel.accessToken) {
                    self?.keychainService.set(userID, forKey: K.keychainUserIDKey)
                }
                self?.view?.goToFeedVC()
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
        
        /*
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
         */
    }
}
