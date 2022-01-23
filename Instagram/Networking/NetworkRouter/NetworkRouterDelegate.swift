//
//  NetworkService.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import UIKit
import Alamofire

protocol NetworkRouterDelegate {
    func noInterceptorRequest(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
    func upload(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
}
