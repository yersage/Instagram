//
//  RequestManager.swift
//  Instagram
//
//  Created by Yersage on 26.01.2022.
//

import Foundation
import Alamofire

protocol RequestDelegate {
    func request(_ route: EndPointType, interceptor: RequestInterceptor?, serializationType: SerializationType, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}

enum SerializationType {
    case JSON
    case Data
}

class RequestManager: RequestDelegate {
    func request(_ route: EndPointType, interceptor: RequestInterceptor?, serializationType: SerializationType, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()) {
        
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
