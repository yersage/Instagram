//
//  NetworkContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

public typealias HTTPHeaders = [String: String]

protocol EndPointType {
    var url: URL? { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var parameters: [String: Any]? { get }
    var formDataParts: [FormData]? { get }
    var encoding: ParameterEncoding { get }
}
