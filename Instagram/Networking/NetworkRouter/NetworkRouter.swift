//
//  NetworkRouter.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import Foundation
import Alamofire

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

class NetworkRouter: NetworkRouterDelegate {
    
    func requestJSONResponse(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, completion: @escaping NetworkRouterCompletion) {
        AF.request(
            route.url!,
            method: route.method,
            parameters: route.parameters,
            encoding: route.encoding,
            interceptor: interceptor
        ).responseJSON { response in
            completion(response.data, response.response, response.error)
        }
    }
    
    func requestDataResponse(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, completion: @escaping NetworkRouterCompletion) {
        AF.request(
            route.url!,
            method: route.method,
            parameters: route.parameters,
            encoding: route.encoding,
            interceptor: interceptor
        ).responseData { response in
            completion(response.data, response.response, response.error)
        }
    }
    
    func upload(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, completion: @escaping NetworkRouterCompletion) {
        AF.upload(multipartFormData: { multipartFormData in
            for formData in route.formDataParts! {
                multipartFormData.append(formData.data, withName: formData.withName, fileName: formData.fileName, mimeType: formData.mimeType)
            }
        }, to: route.url!, method: route.method, interceptor: interceptor).responseData { response in
            completion(response.data, response.response, response.error)
        }
    }
}
