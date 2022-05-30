//
//  EmailPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class EmailPresenter: EmailPresenterDelegate {
    weak var view: EmailViewDelegate?
    var coordinator: SignUpCoordinator?

    private let emailAvailabilityService = EmailAvailabilityService(requestService: RequestManager())
    
    func signInButtonPressed() {
        coordinator?.navigationController.popViewController(animated: false)
    }
    
    func nextButtonPressed(email: String) {            
        let isEmailFormatValid = NSPredicate(format:"SELF MATCHES[c] %@", K.emailRegEx).evaluate(with: email)
        
        if isEmailFormatValid {
            self.view?.updateLabel(isHidden: true, text: nil)
            self.isEmailAvailable(email: email)
        } else {
            self.view?.updateLabel(isHidden: false, text: "Invalid email format.")
        }
    }
    
    func isEmailAvailable(email: String) {
        emailAvailabilityService.checkEmailAvailability(email: email) { result in
            switch result {
            case .success(_):
                self.view?.updateLabel(isHidden: true, text: nil)
                self.coordinator?.username(authModel: AuthModel(email: email, username: nil, password: nil))
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
