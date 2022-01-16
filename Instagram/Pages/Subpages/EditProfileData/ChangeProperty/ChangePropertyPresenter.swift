//
//  ChangePropertyPresenter.swift
//  PostFeed
//
//  Created by Yersage on 08.01.2022.
//

import Foundation

class ChangePropertyPresenter: ChangePropertyPresenterDelegate {
    
    private let networkService: NetworkService = NetworkAdapter()
    private var view: ChangePropertyViewDelegate
    
    init(view: ChangePropertyViewDelegate) {
        self.view = view
    }
    
    func checkUsername(_ username: String) {
        let usernameRegEx = "\\w{1,30}"
        let usernameTest = NSPredicate(format:"SELF MATCHES[c] %@", usernameRegEx)
        let isUsernameFormatValid = usernameTest.evaluate(with: username)
        
        if isUsernameFormatValid {
            self.view.hideValidationLabel()
            self.isUsernameAvailable(username: username)
        } else {
            self.view.showValidationLabel("Username format is not valid.")
        }
    }
    
    private func isUsernameAvailable(username: String) {
        networkService.load(context: UsernameAvailabilityEndPoint(username: username)) { response in
            switch response {
            case .failure(let error):
                self.view.show(error: error.localizedDescription)
                self.view.showValidationLabel("Error")
            case .success(let statusCode):
                if statusCode == 406 {
                    self.view.showValidationLabel("Username is already in use.")
                } else if statusCode == 200 {
                    self.view.hideValidationLabel()
                }
            }
        }
    }
}
