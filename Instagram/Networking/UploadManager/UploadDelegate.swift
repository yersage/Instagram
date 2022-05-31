//
//  UploadDelegate.swift
//  Instagram
//
//  Created by Yersage on 31.05.2022.
//

import Foundation
import Alamofire

protocol UploadDelegate {
    func upload(_ route: EndPointType, interceptor: RequestInterceptor?, formDataParts: [FormData]?, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}
