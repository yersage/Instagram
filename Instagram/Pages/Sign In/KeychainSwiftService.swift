//
//  KeychainSwiftService.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation
import KeychainSwift

class KeychainSwiftService: KeychainServiceDelegate {
    private let keychain = KeychainSwift()
    
    func set(token: TokenModel) {
        keychain.set(token.accessToken, forKey: K.keychainAccessTokenKey)
        keychain.set(token.refreshToken, forKey: K.keychainRefreshTokenKey)
    }
    
    func get(_ key: String) -> String? {
        return keychain.get(key)
    }
    
    func fetchUserID(from accessToken: String) -> Int? {
        //
        return -1
    }
}
