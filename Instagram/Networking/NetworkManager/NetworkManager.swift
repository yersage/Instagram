//
//  NetworkManager.swift
//  Instagram
//
//  Created by Yersage on 18.01.2022.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

class NetworkManager {
    
    let networkRouter: NetworkRouterDelegate
    
    init(networkRouter: NetworkRouterDelegate) {
        self.networkRouter = networkRouter
    }
    
    func request<T: Decodable>(_ route: EndPointType, completion: @escaping (Result<T, Error>) -> Void) {
        
        networkRouter.request(route) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)) }
            
            do {
                let result: T = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    func request(_ route: EndPointType, completion: @escaping (Result<Int, Error>) -> Void) {
        
        networkRouter.request(route) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)) }
            
            do {
                let result: T = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, Error> {
        switch response.statusCode {
        case 200...299: return .success()
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
