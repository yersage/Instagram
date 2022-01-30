//
//  NetworkManager.swift
//  PostFeed
//
//  Created by Yersage on 26.10.2021.
//

import Foundation
import Alamofire
import KeychainSwift

class KeychainSwiftInterceptor: RequestInterceptor {
    private let requestService: RequestDelegate
    private let tokenService: TokenServiceDelegate
    
    init(requestService: RequestDelegate, tokenService: TokenServiceDelegate) {
        self.requestService = requestService
        self.tokenService = tokenService
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let accessToken = tokenService.getAccessToken() else {
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
        guard let refreshToken = tokenService.getRefreshToken() else {
            completion(false)
            return
        }
        
        requestService.request(InstagramEndPoint.refreshToken(refreshToken: refreshToken), interceptor: nil, serializationType: .JSON) { [weak self] data, response, error in
            
            if error != nil {
                completion(false)
            }
            
            guard let data = data else { completion(false); return }
            
            if let decodedData = try? JSONDecoder().decode(TokenModel.self, from: data) {
                self?.tokenService.setAccessToken(accessToken: decodedData.accessToken)
                self?.tokenService.setRefreshToken(refreshToken: decodedData.refreshToken)
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
}
