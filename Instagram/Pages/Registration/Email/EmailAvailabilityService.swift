//
//  EmailAvailabilityService.swift
//  Instagram
//
//  Created by Yersage on 29.01.2022.
//

import Foundation

class EmailAvailabilityService {
    
    private let requestService: RequestDelegate
    
    init(requestService: RequestDelegate) {
        self.requestService = requestService
    }
    
    func checkEmailAvailability(email: String, completion: @escaping (Result<Int, Error>) -> ()) {
        requestService.request(InstagramEndPoint.emailAvailability(email: email), interceptor: nil, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
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
