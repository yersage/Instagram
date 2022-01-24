//
//  AlamofireInterceptorDelegate.swift
//  Instagram
//
//  Created by Yersage on 24.01.2022.
//

import Foundation
import Alamofire

protocol RequestInterceptorDelegate: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void)
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void)
}
