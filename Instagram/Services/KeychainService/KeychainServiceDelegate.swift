//
//  KeychainServiceDelegate.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation

protocol KeychainServiceDelegate: UserIDFetchable {
    func set(_ value: String, forKey key: String)
    func get(_ key: String) -> String?
}

protocol UserIDFetchable {
    func fetchUserID(from token: String) -> String?
}
