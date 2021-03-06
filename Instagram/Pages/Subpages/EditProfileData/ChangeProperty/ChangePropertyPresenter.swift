//
//  ChangePropertyPresenter.swift
//  PostFeed
//
//  Created by Yersage on 08.01.2022.
//

import Foundation

final class ChangePropertyPresenter: ChangePropertyPresenterDelegate {
    
    weak var view: ChangePropertyViewDelegate?
    private let usernameAvailabilityService = UsernameAvailabilityService(requestService: RequestManager())

    func checkUsername(_ username: String) {
        let usernameRegEx = "\\w{1,30}"
        let usernameTest = NSPredicate(format:"SELF MATCHES[c] %@", usernameRegEx)
        let isUsernameFormatValid = usernameTest.evaluate(with: username)
        
        if isUsernameFormatValid {
            self.view?.hideValidationLabel()
            self.isUsernameAvailable(username: username)
        } else {
            self.view?.showValidationLabel("Username format is not valid.")
        }
    }
    
    private func isUsernameAvailable(username: String) {
        usernameAvailabilityService.checkUsernameAvailability(username: username) { result in
            switch result {
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
                self.view?.showValidationLabel("Error")
            case .success(let statusCode):
                if statusCode == 201 {
                    self.view?.showValidationLabel("Username is already in use.")
                } else if statusCode == 200 {
                    self.view?.hideValidationLabel()
                }
            }
        }
    }
}
