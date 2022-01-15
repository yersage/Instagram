//
//  NetworkManager.swift
//  PostFeed
//
//  Created by Yersage on 26.10.2021.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    
    let retryLimit = 3
    let loginAddress = "http://localhost:8090/auth/login"
    let refreshAddress = "http://localhost:8090/auth/refresh-token"
    var request: Alamofire.Request?
    
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
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let refreshToken = UserDefaultsManager.shared.getRefreshToken() else { completion(false); return }
        let header: HTTPHeader = HTTPHeader(name: "token", value: refreshToken)
        AF.request(refreshAddress, method: .post, encoding: JSONEncoding.default, headers: HTTPHeaders([header])).responseJSON { response in
            
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
