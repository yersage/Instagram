//
//  SignInPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class SignInPresenter: SignInPresenterDelegate {
    
    weak var view: SignInViewDelegate?
    var coordinator: MainCoordinator?
    
    private let keychainService: KeychainServiceDelegate = KeychainService()
    private let userIDFetchService: UserIDFetchable = JWTDecoder()
    private let loginService = LoginService()
    
    func loginButtonPressed(username: String, password: String) {
        
        if username == "" || password == "" {
            self.view?.show(error: "Username or password is not provided.")
        }
        
        loginService.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let tokenModel):
                self?.keychainService.set(tokenModel.accessToken, forKey: K.keychainAccessTokenKey)
                self?.keychainService.set(tokenModel.refreshToken, forKey: K.keychainRefreshTokenKey)
                
                if let userID = self?.userIDFetchService.fetchUserID(from: tokenModel.accessToken) {
                    self?.keychainService.set(userID, forKey: K.keychainUserIDKey)
                }
                
                self?.coordinator?.signIn()
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
    }
    
    func signUpButtonPressed() {
        coordinator?.signUp()
    }
}
