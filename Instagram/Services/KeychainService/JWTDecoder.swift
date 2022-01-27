//
//  JWTDecoder.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation

class JWTDecoder: UserIDFetchable {
    func fetchUserID(from token: String) -> String? {
        let payload = getPayload(from: token)
        return payload?.userId
    }
    
    private func getPayload(from token: String) -> JWTPayloadModel? {
        let jwtSegments = token.components(separatedBy: ".")
        let payloadString = jwtSegments[1]
        let jwtPayloadModel = decodeJWTPart(payloadString)
        return jwtPayloadModel
    }
    
    private func decodeJWTPart(_ value: String) -> JWTPayloadModel? {
        guard let bodyData = base64UrlDecode(value),
              let jwtPayloadModel = try? JSONDecoder().decode(JWTPayloadModel.self, from: bodyData) else {
            return nil
        }
        
        return jwtPayloadModel
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
}
