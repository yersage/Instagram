//
//  WelcomePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class WelcomePresenter: WelcomePresenterDelegate {
    weak var view: WelcomeViewDelegate?
    var coordinator: SignUpCoordinator?
    
    private let keychainService: KeychainServiceDelegate = KeychainService()
    private let userIDFetchService: UserIDFetchable = JWTDecoder()
    private let authService = LoginService()
    
    let authModel: AuthModel
    
    init (authModel: AuthModel) {
        self.authModel = authModel
    }
    
    func nextButtonPressed() {
        authService.login(username: authModel.username!, password: authModel.password!) { [weak self] result in
            switch result {
            case .success(let tokenModel):
                self?.keychainService.set(tokenModel.accessToken, forKey: K.keychainAccessTokenKey)
                self?.keychainService.set(tokenModel.refreshToken, forKey: K.keychainRefreshTokenKey)
                
                if let userID = self?.userIDFetchService.fetchUserID(from: tokenModel.accessToken) {
                    self?.keychainService.set(userID, forKey: K.keychainUserIDKey)

                }
                
                self?.coordinator?.finish()
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
    }
}
