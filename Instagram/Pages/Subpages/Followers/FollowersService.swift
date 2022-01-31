//
//  FollowersService.swift
//  Instagram
//
//  Created by Yersage on 31.01.2022.
//

import Foundation
import Alamofire

class FollowersService {
    private let requestService: RequestDelegate
    private let interceptor: RequestInterceptor
    
    init(requestService: RequestDelegate, interceptor: RequestInterceptor) {
        self.requestService = requestService
        self.interceptor = interceptor
    }
    
    func getFollowersList(by userID: Int, completion: @escaping (Result<[ProfileModel], Error>) -> ()) {
        requestService.request(InstagramEndPoint.followersList(userID: userID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newPosts = try JSONDecoder().decode([ProfileModel].self, from: data)
                completion(.success(newPosts))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
}
