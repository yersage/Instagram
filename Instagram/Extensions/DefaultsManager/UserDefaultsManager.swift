//
//  UserDefaultsManager.swift
//  PostFeed
//
//  Created by Yersage on 26.10.2021.
//

import Foundation

class UserDefaultsManager {
    
    enum Key: String {
        case username
        case password
        case refreshToken
        case accessToken
        case isSignedIn
        case userId
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    func getUserCredentials() -> (username: String?, password: String?) {
        let username = UserDefaults.standard.string(forKey: Key.username.rawValue)
        let password = UserDefaults.standard.string(forKey: Key.password.rawValue)
        return (username, password)
    }
    
    func setUserCredentials(username: String, password: String) {
        UserDefaults.standard.set(username, forKey: Key.username.rawValue)
        UserDefaults.standard.set(password, forKey: Key.password.rawValue)
    }
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: Key.accessToken.rawValue)
    }
    
    func setAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: Key.accessToken.rawValue)
    }
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: Key.refreshToken.rawValue)
    }
    
    func setRefreshToken(token: String) {
        UserDefaults.standard.set(token, forKey: Key.refreshToken.rawValue)
    }
    
    func signInUser() {
        UserDefaults.standard.set(true, forKey: Key.isSignedIn.rawValue)
    }
    
    func signOutUser() {
        UserDefaults.standard.set(false, forKey: Key.isSignedIn.rawValue)
    }
    
    func isUserSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Key.isSignedIn.rawValue)
    }
    
    private func setUserID(_ userID: Int) {
        UserDefaults.standard.set(userID, forKey: Key.userId.rawValue)
    }
    
    func getUserID() -> Int {
        return UserDefaults.standard.integer(forKey: Key.userId.rawValue)
    }
    
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
        setUserCredentials(username: username, password: password)
        setAccessToken(token: accessToken)
        setRefreshToken(token: refreshToken)
        let payload = decode(jwtToken: accessToken)
        let userId = Int(payload.userId) ?? -1
        setUserID(userId)
        signInUser()
    }
}
