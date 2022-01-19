//
//  UsernamePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class UsernamePresenter: UsernamePresenterDelegate {
    weak var view: UsernameViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()
    
    func isUsernameAvailable(username: String) {
        networkManager.request(InstagramEndPoint.usernameAvailability(username: username)) { result in
            switch result {
            case .success(_):
                self.view?.hideLabel()
                self.view?.goToPasswordVC()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
    
    func isUsernameAcceptable(username: String) {
        let usernameRegEx = "\\w{1,30}"
        let usernameTest = NSPredicate(format:"SELF MATCHES[c] %@", usernameRegEx)
        let isUsernameFormatValid = usernameTest.evaluate(with: username)
        
        if isUsernameFormatValid {
            self.view?.hideLabel()
            self.isUsernameAvailable(username: username)
        } else {
            self.view?.showLabel(text: "Invalid username format.")
        }
    }
}
