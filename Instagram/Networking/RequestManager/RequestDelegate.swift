//
//  RequestDelegate.swift
//  Instagram
//
//  Created by Yersage on 31.05.2022.
//

import Foundation
import Alamofire

protocol RequestDelegate {
    func request(_ route: EndPointType, interceptor: RequestInterceptor?, serializationType: SerializationType, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}
