//
//  SignInPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

class SignInPresenter: SignInPresenterDelegate {
    private let view: SignInViewDelegate
    private let networkService: NetworkRouterDelegate = NetworkRouter()
    
    init(view: SignInViewDelegate) {
        self.view = view
    }
    
    func login(username: String, password: String) {
        if username == "" || password == "" {
            self.view.show(error: "Username or password is not provided.")
        }
        
        networkService.authorize(parameters: ["username": username, "password": password]) { result in
            switch result {
            case .success(let data):
                guard let tokenModel = try? JSONDecoder().decode(TokenModel.self, from: data)
                else {
                    return 
                }
                UserDefaultsManager.shared.signIn(username: username, password: password, accessToken: tokenModel.accessToken, refreshToken: tokenModel.refreshToken)
                self.view.goToFeedVC()
            case .failure(let error):
                self.view.show(error: error.localizedDescription)
            }
        }
    }
}
