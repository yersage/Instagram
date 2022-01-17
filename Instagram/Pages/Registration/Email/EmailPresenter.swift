//
//  EmailPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

class EmailPresenter: EmailPresenterDelegate {
    weak var view: EmailViewDelegate?
    private let networkService: NetworkService = NetworkAdapter()

    func isEmailAvailable(email: String) {
        networkService.load(context: EmailAvailabilityEndPoint(email: email)) { response in
            switch response {
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            case .success(let statusCode):
                if statusCode == 406 {
                    self.view?.showLabel(text: "Email is already in use.")
                } else if statusCode == 200 {
                    self.view?.hideLabel()
                    self.view?.goToUsernameVC()
                }
            }
        }
    }
    
    func isEmailAcceptable(email: String) {
        let emailRegEx =
            "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        let isEmailFormatValid = emailTest.evaluate(with: email)
        
        if isEmailFormatValid {
            self.view?.hideLabel()
            self.isEmailAvailable(email: email)
        } else {
            self.view?.showLabel(text: "Invalid email format.")
        }
    }
}
