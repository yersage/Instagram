//
//  DataRequestBuilderDelegate.swift
//  Instagram
//
//  Created by Yersage on 24.01.2022.
//

import Foundation
import Alamofire

protocol DataRequestBuilderDelegate: AnyObject {
    func getDataRequest(for route: EndPointType, interceptor: RequestInterceptorDelegate?) -> DataRequest
}
