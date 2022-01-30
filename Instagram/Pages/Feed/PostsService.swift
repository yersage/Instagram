//
//  PostsService.swift
//  Instagram
//
//  Created by Yersage on 30.01.2022.
//

import Foundation

class PostsService {
    private let requestManager: RequestDelegate = RequestManager()
    
    func requestPosts(page: Int, interceptor: RequestInterceptorDelegate, completion: @escaping (Result<[PostModel], Error>) -> ()) {
        requestManager.request(InstagramEndPoint.feedPosts(page: page), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
    
    func like(postID: String, interceptor: RequestInterceptorDelegate, completion: @escaping (Result<PostModel, Error>) -> ()) {
        requestManager.request(InstagramEndPoint.postLike(postID: postID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
    
    func unlike(postID: String, interceptor: RequestInterceptorDelegate, completion: @escaping (Result<PostModel, Error>) -> ()) {
        requestManager.request(InstagramEndPoint.postUnlike(postID: postID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
