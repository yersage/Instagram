//
//  UsernamePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

class UsernamePresenter: UsernamePresenterDelegate {
    private let view: UsernameViewDelegate
    private let networkService: NetworkRouterDelegate = NetworkAdapter()
    
    init(view: UsernameViewDelegate) {
        self.view = view
    }
    
    func isUsernameAvailable(username: String) {
        networkService.load(context: UsernameAvailabilityEndPoint(username: username)) { response in
            switch response {
            case .failure(let error):
                self.view.show(error: error.localizedDescription)
            case .success(let statusCode):
                if statusCode == 406 {
                    self.view.showLabel(text: "Username is already in use.")
                } else if statusCode == 200 {
                    self.view.hideLabel()
                    self.view.goToPasswordVC()
                }
            }
        }
    }
    
    func isUsernameAcceptable(username: String) {
        let usernameRegEx = "\\w{1,30}"
        let usernameTest = NSPredicate(format:"SELF MATCHES[c] %@", usernameRegEx)
        let isUsernameFormatValid = usernameTest.evaluate(with: username)
        
        if isUsernameFormatValid {
            self.view.hideLabel()
            self.isUsernameAvailable(username: username)
        } else {
            self.view.showLabel(text: "Invalid username format.")
        }
    }
}
