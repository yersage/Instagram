//
//  NetworkRouter.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import Foundation
import Alamofire

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterDelegate {
    private let interceptor = Interceptor()
    
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        guard let url = route.url else {
            completion(nil, nil, NetworkError.urlValid)
            return
        }
        
        AF.request(
            url,
            method: route.method,
            parameters: route.parameters,
            encoding: route.encoding,
            interceptor: interceptor
        ).responseJSON { response in
            completion(response.data, response.response, response.error)
        }
    }
    
    func upload(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        guard let url = route.url else {
            completion(nil, nil, NetworkError.urlValid)
            return
        }
        
        guard let formDataParts = route.formDataParts else {
            completion(nil, nil, NetworkError.invalidParameters)
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            for formData in formDataParts {
                multipartFormData.append(formData.data, withName: formData.withName, fileName: formData.fileName, mimeType: formData.mimeType)
            }
        }, to: url, method: route.method, interceptor: interceptor).responseData { response in
            completion(response.data, response.response, response.error)
        }
    }
}
