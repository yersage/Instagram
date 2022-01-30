//
//  SearchService.swift
//  Instagram
//
//  Created by Yersage on 30.01.2022.
//

import Foundation
import Alamofire

class SearchService {
    private let requestService: RequestDelegate
    private let interceptor: RequestInterceptor
    
    init(requestService: RequestDelegate, interceptor: RequestInterceptor) {
        self.requestService = requestService
        self.interceptor = interceptor
    }
    
    func searchResults(for name: String, completion: @escaping (Result<[ProfileModel], Error>) -> ()) {
        requestService.request(InstagramEndPoint.search(name: name), interceptor: interceptor, serializationType: .JSON) { data, response, error in
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
