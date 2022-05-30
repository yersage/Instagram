//
//  ConfirmationPresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class ConfirmationPresenter: ConfirmationPresenterDelegate {
    weak var view: ConfirmationViewDelegate?
    var coordinator: SignUpCoordinator?

    private let accountVerificationService = AccountVerificationService(requestService: RequestManager())
    
    let authModel: AuthModel
    
    init (authModel: AuthModel) {
        self.authModel = authModel
    }
    
    func viewDidLoad() {
        view?.setupLabel(email: authModel.email!)
    }
    
    func nextButtonPressed(verificationCode: String) {
        accountVerificationService.verify(confirmationCode: verificationCode, email: authModel.email!) { result in
            switch result {
            case .success(let statusCode):
                if statusCode == 200 {
                    self.view?.updateLabel(isHidden: true, text: nil)
                    self.coordinator?.welcome(authModel: self.authModel)
                }
                if statusCode == 201 {
                    self.view?.updateLabel(isHidden: true, text: "Confirmation code is wrong.")
                }
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
