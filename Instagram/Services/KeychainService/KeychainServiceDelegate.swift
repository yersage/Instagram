//
//  KeychainServiceDelegate.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation

protocol KeychainServiceDelegate {
    func set(_ value: String, forKey key: String)
    func get(_ key: String) -> String?
}
