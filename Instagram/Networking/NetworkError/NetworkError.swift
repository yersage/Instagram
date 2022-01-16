//
//  NetworkError.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

enum NetworkError: AppError {
    
    case serverError(description: String)
    case dataLoad
    case unknown
    case noConnection
    case urlValid
    case noData
    case invalidParameters
    
    var description: String {
        switch self {
        case .serverError(let description):
            return description
        case .dataLoad:
            return "Error loading data."
        case .unknown:
            return "Unknown error."
        case .urlValid:
            return "URL is invalid."
        case .noConnection:
            return "No internet connection."
        case .noData:
            return "No content."
        case .invalidParameters:
            return "One of the parameters is invalid."
        }
    }
}
