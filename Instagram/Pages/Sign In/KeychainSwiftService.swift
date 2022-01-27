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
    private let jwtDecoder = JWTDecoder()
    
    func set(_ value: String, forKey key: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(_ key: String) -> String? {
        return keychain.get(key)
    }
    
    func fetchUserID(from token: String) -> String? {
        let userID = jwtDecoder.fetchUserID(from: token)
        return userID
    }
}