//
//  UploadRequestBuilder.swift
//  Instagram
//
//  Created by Yersage on 24.01.2022.
//

import Foundation
import Alamofire

protocol UploadRequestBuilderDelegate: AnyObject {
    func getUploadRequest(for route: EndPointType, interceptor: RequestInterceptorDelegate?) -> UploadRequest
}
