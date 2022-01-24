//
//  NetworkManager.swift
//  PostFeed
//
//  Created by Yersage on 26.10.2021.
//

import Foundation
import Alamofire
import KeychainSwift

class KeychainSwiftInterceptor: RequestInterceptorDelegate {
    
    private let keychain = KeychainSwift()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let accessToken = keychain.get(K.keychainAccessTokenKey) else {
            completion(.success(urlRequest))
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < K.refreshTokenRetryLimit else {
            completion(.doNotRetry)
            return
        }
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let refreshToken = self.keychain.get(K.keychainRefreshTokenKey) else { completion(false); return }
        
        guard let url = InstagramEndPoint.refreshToken(refreshToken: refreshToken).url else {
            completion(false); return
        }
        
        AF.request(url, method: .post).responseJSON { [self] response in
            
            if let safeData = response.data {
                if let decodedData = try? JSONDecoder().decode(TokenModel.self, from: safeData) {
                    keychain.set(decodedData.accessToken, forKey: K.keychainAccessTokenKey)
                    keychain.set(decodedData.refreshToken, forKey: K.keychainRefreshTokenKey)
                    completion(true)
                } else {
                    completion(false)
                }
                
            } else {
                completion(false)
            }
        }
    }
}
