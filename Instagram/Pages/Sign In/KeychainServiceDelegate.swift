//
//  KeychainServiceDelegate.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation

protocol KeychainServiceDelegate: UserIDFetchable {
    func set(token: TokenModel)
    func get(_ key: String) -> String?
}

protocol UserIDFetchable {
    func fetchUserID(from accessToken: String) -> Int?
}
