//
//  PasswordPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

class PasswordPresenter: PasswordPresenterDelegate {
    private let view: PasswordViewDelegate
    private let networkService: NetworkService = NetworkAdapter()
    
    init(view: PasswordViewDelegate) {
        self.view = view
    }
    
    func isPasswordAcceptable(password: String) {
        let answer = isPasswordValid(password)
        
        if answer {
            self.view.hideLabel()
            self.view.goToWelcomeVC()
        } else {
            self.view.showLabel(text: "Invalid password format.")
        }
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9]).{6,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        return passwordTest.evaluate(with: password)
    }
}
