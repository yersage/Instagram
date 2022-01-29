//
//  RequestDelegate.swift
//  Instagram
//
//  Created by Yersage on 29.01.2022.
//

import Foundation

protocol RequestDelegate {
    func request(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, serializationType: SerializationType, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}
