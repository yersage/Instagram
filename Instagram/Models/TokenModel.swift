//
//  TokenModel.swift
//  PostFeed
//
//  Created by Yersage on 10.09.2021.
//

import Foundation

class TokenModel: Codable {
    @objc dynamic var accessToken: String = ""
    @objc dynamic var refreshToken: String = ""
}
