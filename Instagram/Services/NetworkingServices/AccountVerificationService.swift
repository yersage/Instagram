//
//  ConfirmationService.swift
//  Instagram
//
//  Created by Yersage on 29.01.2022.
//

import Foundation

class AccountVerificationService {
    
    private let requestService: RequestDelegate
    
    init(requestService: RequestDelegate) {
        self.requestService = requestService
    }
    
    func verify(confirmationCode: String, email: String, completion: @escaping (Result<Int, Error>) -> ()) {
        requestService.request(InstagramEndPoint.accountVerification(confirmationCode: confirmationCode, email: email), interceptor: nil, serializationType: .JSON) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.dataLoad))
                return
            }
            
            self.handleNetworkResponse(response) { result in
                completion(result)
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse, completion: @escaping (Result<Int, Error>) -> Void) {
        switch response.statusCode {
        case 200...299:
            completion(.success(response.statusCode))
        case 401...500:
            completion(.failure(NetworkError.dataLoad))
        default:
            completion(.failure(NetworkError.unknown))
        }
    }
}
