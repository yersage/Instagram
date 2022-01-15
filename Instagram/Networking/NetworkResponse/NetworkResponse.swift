//
//  NetworkResponse.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

protocol NetworkResponse {
    var data: Data? { get }
    var networkError: NetworkError? { get }
}

extension NetworkResponse {
    func decode<T: Decodable>() -> T? {
        guard let data = data else { return nil }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            dump(error)
            return nil
        }
    }
}
