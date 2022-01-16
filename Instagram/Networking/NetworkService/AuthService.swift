//
//  AuthService.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import Foundation
import Alamofire

class AuthService {
    func authorize(parameters: [String: Any]?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = InstagramAPI.login.url else {
            completion(.failure(NetworkError.urlValid))
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
