//
//  UploadManager.swift
//  Instagram
//
//  Created by Yersage on 26.01.2022.
//

import Foundation
import Alamofire

protocol UploadDelegate {
    func upload(_ route: EndPointType, interceptor: RequestInterceptor?, formDataParts: [FormData]?, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}

class UploadManager: UploadDelegate {
    func upload(_ route: EndPointType, interceptor: RequestInterceptor?, formDataParts: [FormData]?, completion: @escaping NetworkRouterCompletion) {
        
        let uploadRequest = AF.upload(multipartFormData: { multipartFormData in
            if formDataParts != nil {
                for formData in formDataParts! {
                    multipartFormData.append(formData.data,
                                             withName: formData.withName,
                                             fileName: formData.fileName,
                                             mimeType: formData.mimeType)
                }
            }
        }, to: route.url!, method: route.method, interceptor: interceptor)
        
        uploadRequest.responseData { response in
            completion(response.data, response.response, response.error)
        }
    }
}
