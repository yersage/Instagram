//
//  PasswordPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class PasswordPresenter: PasswordPresenterDelegate {
    weak var view: PasswordViewDelegate?
    var coordinator: SignUpCoordinator?
    
    private let signUpService = SignUpService(requestService: RequestManager())
    
    var authModel: AuthModel
    
    init (authModel: AuthModel) {
        self.authModel = authModel
    }
    
    func nextButtonPressed(password: String) {
        let isPasswordValid = NSPredicate(format: "SELF MATCHES %@", K.passwordRegEx).evaluate(with: password)
        
        if isPasswordValid {
            view?.updateLabel(isHidden: true, text: nil)
            authModel.password = password
            self.signup(authModel: authModel)
        } else {
            view?.updateLabel(isHidden: false, text: "Invalid password format.")
        }
    }
    
    func signup(authModel: AuthModel) {
        signUpService.signUp(username: authModel.username!, password: authModel.password!, email: authModel.email!) { result in
            switch result {
            case .success(_):
                self.coordinator?.confirmation(authModel: authModel)
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
