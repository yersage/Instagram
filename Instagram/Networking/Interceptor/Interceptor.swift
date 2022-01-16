//
//  NetworkManager.swift
//  PostFeed
//
//  Created by Yersage on 26.10.2021.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let accessToken = UserDefaultsManager.shared.getAccessToken() else {
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
        guard let refreshToken = UserDefaultsManager.shared.getRefreshToken() else { completion(false); return }
        
        guard let url = InstagramAPI.refreshToken(refreshToken: refreshToken).url else {
            completion(false); return
        }
        
        AF.request(url, method: .post).responseJSON { response in
            
            if let safeData = response.data {
                if let decodedData = try? JSONDecoder().decode(TokenModel.self, from: safeData) {
                    UserDefaultsManager.shared.setAccessToken(token: decodedData.accessToken)
                    UserDefaultsManager.shared.setRefreshToken(token: decodedData.refreshToken)
                    completion(true)
                } else {
                    print("Couldn't load tokens")
                    completion(false)
                }
                
            } else {
                completion(false)
            }
        }
    }
}
