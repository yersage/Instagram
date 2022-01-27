//
//  PayloadModel.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import Foundation

struct JWTPayloadModel: Decodable {
    let userId: String
    let authorities: [String]
    let tokenId: String
    let iat: Int
    let exp: Int
}
