//
//  NetworkManager.swift
//  Instagram
//
//  Created by Yersage on 18.01.2022.
//

import Foundation

class NetworkManager {
    private let interceptor = KeychainSwiftInterceptor()
    private let networkRouter = NetworkRouter()

    func upload<T: Decodable>(_ route: EndPointType, completion: @escaping (Result<T, Error>) -> Void) {
        
        networkRouter.upload(route, interceptor: interceptor) { data, response, error in
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
    
    func request<T: Decodable>(_ route: EndPointType, completion: @escaping (Result<T, Error>) -> Void) {
        networkRouter.requestJSONResponse(route, interceptor: interceptor) { data, response, error in
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
    
    func imageRequest(_ route: EndPointType, completion: @escaping (Result<Data, Error>) -> Void) {
        networkRouter.requestDataResponse(route, interceptor: interceptor) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            completion(.success(data))
        }
    }
    
    func noInterceptorRequest<T: Decodable>(_ route: EndPointType, completion: @escaping (Result<T, Error>) -> Void) {
        
        networkRouter.requestJSONResponse(route, interceptor: nil) { data, response, error in
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
    
    func request(_ route: EndPointType, completion: @escaping (Result<Int, Error>) -> Void) {
        networkRouter.requestJSONResponse(route, interceptor: interceptor) { _, response, error in
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
