//
//  AuthService.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import Foundation
import Alamofire

class AuthService {
    func authorize(_ route: EndPointType, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = route.url else {
            completion(.failure(NetworkError.urlValid))
            return
        }
        
        AF.request(url, method: .post, parameters: route.parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.noData))
            }
        }
    }
}
