//
//  PostsService.swift
//  Instagram
//
//  Created by Yersage on 30.01.2022.
//

import Foundation
import Alamofire

class PostsService {
    private let requestService: RequestDelegate
    private let interceptor: RequestInterceptor
    
    init(requestService: RequestDelegate, interceptor: RequestInterceptor) {
        self.requestService = requestService
        self.interceptor = interceptor
    }
    
    func requestPosts(page: Int, completion: @escaping (Result<[PostModel], Error>) -> ()) {
        requestService.request(InstagramEndPoint.feedPosts(page: page), interceptor: interceptor, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newPosts = try JSONDecoder().decode([PostModel].self, from: data)
                completion(.success(newPosts))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    func like(postID: String, completion: @escaping (Result<PostModel, Error>) -> ()) {
        requestService.request(InstagramEndPoint.postLike(postID: postID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
    
    func unlike(postID: String, completion: @escaping (Result<PostModel, Error>) -> ()) {
        requestService.request(InstagramEndPoint.postUnlike(postID: postID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
