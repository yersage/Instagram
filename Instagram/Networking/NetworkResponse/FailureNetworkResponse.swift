//
//  FailureNetworkResponse.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class FailureNetworkResponse: NetworkResponse {
    var data: Data? { return nil }
    let networkError: NetworkError?
    
    init(networkError: NetworkError) {
        self.networkError = networkError
    }
}
