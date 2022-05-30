//
//  UsernamePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class UsernamePresenter: UsernamePresenterDelegate {
    
    weak var view: UsernameViewDelegate?
    var coordinator: SignUpCoordinator?

    private let usernameAvailabilityService = UsernameAvailabilityService(requestService: RequestManager())
    
    var authModel: AuthModel
    
    init (authModel: AuthModel) {
        self.authModel = authModel
    }
    
    func nextButtonPressed(username: String) {
        let isUsernameFormatValid = NSPredicate(format:"SELF MATCHES[c] %@", K.usernameRegEx).evaluate(with: username)
        
        if isUsernameFormatValid {
            self.view?.updateLabel(isHidden: true, text: nil)
            self.isUsernameAvailable(username: username)
        } else {
            self.view?.updateLabel(isHidden: false, text: "Invalid username format.")
        }
    }
    
    func isUsernameAvailable(username: String) {
        usernameAvailabilityService.checkUsernameAvailability(username: username) {  [weak self] result in
            switch result {
            case .success(_):
                self?.view?.updateLabel(isHidden: true, text: nil)
                self?.authModel.username = username
                guard let authModel = self?.authModel else { return }
                self?.coordinator?.password(authModel: authModel)
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
    }
}
