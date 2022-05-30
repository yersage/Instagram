//
//  AuthService.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation

class LoginService {
    private let requestManager = RequestManager()
    
    func login(username: String, password: String, completion: @escaping (Result<TokenModel, Error>) -> ()) {
        requestManager.request(InstagramEndPoint.login(username: username, password: password), interceptor: nil, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            do {
                let tokenModel = try JSONDecoder().decode(TokenModel.self, from: data)
                completion(.success(tokenModel))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
}
