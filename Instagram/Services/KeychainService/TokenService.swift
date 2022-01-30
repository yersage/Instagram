//
//  TokenService.swift
//  Instagram
//
//  Created by Yersage on 30.01.2022.
//

import Foundation
import KeychainSwift

class TokenService: TokenServiceDelegate {
    private let keychainService: KeychainServiceDelegate = KeychainService()
    
    func getAccessToken() -> String? {
        keychainService.get(K.keychainAccessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        keychainService.get(K.keychainRefreshTokenKey)
    }
    
    func setAccessToken(accessToken: String) {
        keychainService.set(accessToken, forKey: K.keychainAccessTokenKey)
    }
    
    func setRefreshToken(refreshToken: String) {
        keychainService.set(refreshToken, forKey: K.keychainRefreshTokenKey)
    }
}
