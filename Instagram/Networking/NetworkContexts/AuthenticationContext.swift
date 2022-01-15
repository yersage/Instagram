//
//  AuthenticationContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class EmailAvailabilityContext: NetworkContext {
    var route: InstagramRoute
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(email: String) {
        route = .emailAvailability(email: email)
    }
}

class UsernameAvailabilityContext: NetworkContext {
    var route: InstagramRoute
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(username: String) {
        route = .usernameAvailability(username: username)
    }
}

class SignUpContext: NetworkContext {
    var route: InstagramRoute { return .signUp }
    var method: NetworkMethod { return .post }
    var encoding: NetworkEncoding { return .json}
    var parameters = [String: Any]()
    
    init(username: String, password: String, email: String) {
        parameters["username"] = username
        parameters["password"] = password
        parameters["email"] = email
    }
}

class AccountVerificationContext: NetworkContext {
    var route: InstagramRoute { return .accountVerification }
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(confirmationCode: String, email: String) {
        parameters["verificationCode"] = confirmationCode
        parameters["email"] = email
    }
}
