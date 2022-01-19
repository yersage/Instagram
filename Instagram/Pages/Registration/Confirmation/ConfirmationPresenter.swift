//
//  ConfirmationPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class ConfirmationPresenter: ConfirmationPresenterDelegate {
    weak var view: ConfirmationViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()
    
    func verify(email: String, verificationCode: String) {
        networkManager.request(InstagramEndPoint.accountVerification(confirmationCode: verificationCode, email: email)) { result in
            switch result {
            case .success(let statusCode):
                if statusCode == 200 {
                    self.view?.hideLabel()
                    self.view?.goToWelcomeVC()
                }
                if statusCode == 201 {
                    self.view?.showLabel()
                }
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
    
    func signup(email: String, password: String, username: String) {
        networkManager.request(InstagramEndPoint.signUp(username: username, password: password, email: email)) { result in
            switch result {
            case .success(let statusCode):
                if statusCode == 200 {
                    self.view?.showWarning()
                }
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
