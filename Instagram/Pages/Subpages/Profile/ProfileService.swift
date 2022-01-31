//
//  ProfileService.swift
//  Instagram
//
//  Created by Yersage on 31.01.2022.
//

import Foundation
import Alamofire

class ProfileService {
    private let requestService: RequestDelegate
    private let interceptor: RequestInterceptor
    
    init(requestService: RequestDelegate, interceptor: RequestInterceptor) {
        self.requestService = requestService
        self.interceptor = interceptor
    }
    
    func getProfilePosts(userID: String, page: Int, completion: @escaping (Result<[PostModel], Error>) -> ()) {
        requestService.request(InstagramEndPoint.profilePosts(userID: userID, page: page), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
    
    func getProfileData(userID: Int, completion: @escaping (Result<ProfileModel, Error>) -> ()) {
        requestService.request(InstagramEndPoint.profileData(userID: userID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newPosts = try JSONDecoder().decode(ProfileModel.self, from: data)
                completion(.success(newPosts))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    func follow(userID: String, completion: @escaping (Result<ProfileModel, Error>) -> ()) {
        requestService.request(InstagramEndPoint.follow(userID: userID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newPosts = try JSONDecoder().decode(ProfileModel.self, from: data)
                completion(.success(newPosts))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    func unfollow(userID: String, completion: @escaping (Result<ProfileModel, Error>) -> ()) {
        requestService.request(InstagramEndPoint.unfollow(userID: userID), interceptor: interceptor, serializationType: .JSON) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newPosts = try JSONDecoder().decode(ProfileModel.self, from: data)
                completion(.success(newPosts))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
}
