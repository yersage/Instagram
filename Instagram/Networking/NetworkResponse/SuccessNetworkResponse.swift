//
//  SuccessNetworkResponse.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class SuccessNetworkResponse: NetworkResponse {
    var data: Data?
    var networkError: NetworkError? = nil
    
    init(data: Data?) {
        self.data = data
    }
}
