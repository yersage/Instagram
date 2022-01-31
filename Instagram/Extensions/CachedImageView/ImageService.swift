//
//  ImageService.swift
//  Instagram
//
//  Created by Yersage on 31.01.2022.
//

import Foundation
import Alamofire

class ImageService {
    private let requestService: RequestDelegate
    private let interceptor: RequestInterceptor
    
    init(requestService: RequestDelegate, interceptor: RequestInterceptor) {
        self.requestService = requestService
        self.interceptor = interceptor
    }
    
    func getPostImage(postID: Int, completion: @escaping (Result<Data, Error>) -> ()) {
        requestService.request(InstagramEndPoint.postImage(postID: postID), interceptor: interceptor, serializationType: .Data) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            completion(.success(data))
        }
    }
    
    func getProfileImage(userID: Int, completion: @escaping (Result<Data, Error>) -> ()) {
        requestService.request(InstagramEndPoint.profileImage(userID: userID), interceptor: interceptor, serializationType: .Data) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            completion(.success(data))
        }
    }
}
