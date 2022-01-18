//
//  NetworkContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation
import Alamofire

protocol EndPointType {
    var url: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var formDataParts: [FormData]? { get }
    var encoding: ParameterEncoding { get }
}

struct FormData {
    var data: Data
    var withName: String
    var fileName: String?
    var mimeType: String?
}
