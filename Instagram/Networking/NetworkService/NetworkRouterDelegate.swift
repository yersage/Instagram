//
//  NetworkService.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import UIKit
import Alamofire

protocol NetworkRouterDelegate {
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
    func upload(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
}
