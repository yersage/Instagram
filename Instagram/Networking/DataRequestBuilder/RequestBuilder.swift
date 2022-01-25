//
//  DataRequestBuilder.swift
//  Instagram
//
//  Created by Yersage on 24.01.2022.
//

import Foundation
import Alamofire

class RequestBuilder: DataRequestBuilderDelegate, UploadRequestBuilderDelegate {
    
    func getDataRequest(for route: EndPointType, interceptor: RequestInterceptorDelegate?) -> DataRequest {
        switch interceptor {
        case .some(let interceptor):
            return AF.request(route.url!, method: route.method, parameters: route.parameters, encoding: route.encoding, interceptor: interceptor)
        case .none:
            return AF.request(route.url!, method: route.method, parameters: route.parameters, encoding: route.encoding)
        }
        
    }
    
    func getUploadRequest(for route: EndPointType, interceptor: RequestInterceptorDelegate?) -> UploadRequest {
        switch interceptor {
        case .some(let interceptor):
            return AF.upload(multipartFormData: { multipartFormData in
                for formData in route.formDataParts! {
                    multipartFormData.append(formData.data, withName: formData.withName, fileName: formData.fileName, mimeType: formData.mimeType)
                }
            }, to: route.url!, method: route.method, interceptor: interceptor)
        case .none:
            return AF.upload(multipartFormData: { multipartFormData in
                for formData in route.formDataParts! {
                    multipartFormData.append(formData.data, withName: formData.withName, fileName: formData.fileName, mimeType: formData.mimeType)
                }
            }, to: route.url!, method: route.method)
        }
    }
}
