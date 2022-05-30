//
//  Constants.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import Foundation

struct K {
    static let refreshTokenRetryLimit = 3
    static let keychainUsernameKey = "username"
    static let keychainPasswordKey = "password"
    static let keychainUserIDKey = "userID"
    static let keychainAccessTokenKey = "AccessToken"
    static let keychainRefreshTokenKey = "RefreshToken"
    static let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    static let usernameRegEx = "\\w{1,30}"
    static let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9]).{6,}$"
    static let confirmationCodeWarning = "Given parameters are reserved for one hour. If confirmation code is not provided, parameters will be removed from server."
}
