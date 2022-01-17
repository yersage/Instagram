//
//  ConfirmationPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class ConfirmationPresenter: ConfirmationPresenterDelegate {
    weak var view: ConfirmationViewDelegate?
    private let networkService: NetworkService = NetworkAdapter()
    
    func verify(email: String, verificationCode: String) {
        networkService.load(context: AccountVerificationEndPoint(confirmationCode: verificationCode, email: email)) { response in
            switch response {
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            case .success(let statusCode):
                if statusCode == 200 {
                    self.view?.hideLabel()
                    self.view?.goToWelcomeVC()
                }
                if statusCode == 201 {
                    self.view?.showLabel()
                }
            }
        }
    }
    
    func signup(email: String, password: String, username: String) {
        networkService.load(context: SignUpEndPoint(username: username, password: password, email: email)) { response in
            switch response {
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            case .success(let statusCode):
                if statusCode == 200 {
                    self.view?.showWarning()
                }
            }
        }
    }
}
