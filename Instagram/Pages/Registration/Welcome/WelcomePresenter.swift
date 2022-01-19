//
//  WelcomePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class WelcomePresenter: WelcomePresenterDelegate {
    weak var view: WelcomeViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()

    func login(username: String, password: String) {
        networkManager.request(InstagramEndPoint.login(username: username, password: password), model: TokenModel.self) { result in
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
