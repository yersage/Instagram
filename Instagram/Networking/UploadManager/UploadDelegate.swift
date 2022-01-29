//
//  UploadDelegate.swift
//  Instagram
//
//  Created by Yersage on 29.01.2022.
//

import Foundation

protocol UploadDelegate {
    func upload(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, formDataParts: [FormData]?, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}
