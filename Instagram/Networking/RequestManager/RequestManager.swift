//
//  RequestManager.swift
//  Instagram
//
//  Created by Yersage on 26.01.2022.
//

import Foundation
import Alamofire

enum SerializationType {
    case JSON
    case Data
}

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

class RequestManager: RequestDelegate {
    func request(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, serializationType: SerializationType, completion: @escaping NetworkRouterCompletion) {
        
        let request = AF.request(
            route.url!,
            method: route.method,
            parameters: route.parameters,
            encoding: route.encoding,
            interceptor: interceptor
        )
        
        switch serializationType {
        case .JSON:
            request.responseJSON { response in
                completion(response.data, response.response, response.error)
            }
        case .Data:
            request.responseData { response in
                completion(response.data, response.response, response.error)
            }
        }
    }
}
