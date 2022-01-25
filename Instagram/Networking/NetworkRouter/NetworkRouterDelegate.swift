//
//  NetworkService.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import UIKit
import Alamofire

protocol NetworkRouterDelegate {
    func requestJSONResponse(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, completion: @escaping NetworkRouterCompletion)
    func requestDataResponse(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, completion: @escaping NetworkRouterCompletion)
    func upload(_ route: EndPointType, interceptor: RequestInterceptorDelegate?, completion: @escaping NetworkRouterCompletion)
}
