//
//  NetworkService.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import UIKit
import Alamofire

protocol NetworkRouterDelegate {
    func request(_ route: InstagramAPI, completion: @escaping NetworkRouterCompletion)
    func upload(_ route: InstagramAPI, completion: @escaping NetworkRouterCompletion)
}
