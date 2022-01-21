//
//  SignInPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class SignInPresenter: SignInPresenterDelegate {
    weak var view: SignInViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()
    
    func login(username: String, password: String) {
        
        if username == "" || password == "" {
            self.view?.show(error: "Username or password is not provided.")
        }
        
        networkManager.request(InstagramEndPoint.login(username: username, password: password)) { (result: Result<TokenModel, Error>) -> Void in
            switch result {
            case .success(let tokenModel):
                UserDefaultsManager.shared.signIn(username: username, password: password, accessToken: tokenModel.accessToken, refreshToken: tokenModel.refreshToken)
                self.view?.goToFeedVC()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
