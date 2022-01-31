//
//  CreatePostService.swift
//  Instagram
//
//  Created by Yersage on 31.01.2022.
//

import Foundation
import Alamofire

class CreatePostService {
    private let requestService: RequestDelegate
    private let interceptor: RequestInterceptor
    
    init(requestService: RequestDelegate, interceptor: RequestInterceptor) {
        self.requestService = requestService
        self.interceptor = interceptor
    }
    
    func uploadPost(caption: Data, images: Data, completion: @escaping (Result<PostModel, Error>) -> ()) {
        requestService.request(InstagramEndPoint.uploadPost(caption: caption, images: images), interceptor: interceptor, serializationType: .Data) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newPost = try JSONDecoder().decode(PostModel.self, from: data)
                completion(.success(newPost))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
}
