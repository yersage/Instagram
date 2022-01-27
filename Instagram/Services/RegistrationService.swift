//
//  RegistrationService.swift
//  Instagram
//
//  Created by Yersage on 26.01.2022.
//

import Foundation

class RegistrationService {
    
    private let requestManager = RequestManager()
    
    func noInterceptorRequest<T: Decodable>(_ route: EndPointType, completion: @escaping (Result<T, Error>) -> Void) {
        requestManager.request(route, interceptor: nil, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let result: T = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.dataLoad))
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
