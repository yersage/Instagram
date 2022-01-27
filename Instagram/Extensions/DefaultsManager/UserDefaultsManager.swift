//
//  UserDefaultsManager.swift
//  PostFeed
//
//  Created by Yersage on 26.10.2021.
//

import Foundation
/*
class UserDefaultsManager {
    
    private func decode(jwtToken jwt: String) -> PayloadModel {
      let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? PayloadModel(userId: "-1", authorities: [], tokenId: "", iat: -1, exp: -1)
    }
    
    private func base64UrlDecode(_ value: String) -> Data? {
      var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
        let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
        base64 = base64 + padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    private func decodeJWTPart(_ value: String) -> PayloadModel? {
        guard let bodyData = base64UrlDecode(value),
              let payload = try? JSONDecoder().decode(PayloadModel.self, from: bodyData) else {
            return nil
        }

        return payload
    }
    
    func signIn(username: String, password: String, accessToken: String, refreshToken: String) {
        let payload = decode(jwtToken: accessToken)
        let userId = Int(payload.userId) ?? -1
        setUserID(userId)
    }
}
*/
