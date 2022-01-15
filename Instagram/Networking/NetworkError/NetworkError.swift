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
    
    var description: String {
        switch self {
        case .serverError(let description):
            return description
        case .dataLoad:
            return "Error loading data."
        case .unknown, .urlValid:
            return "Unknown error."
        case .noConnection:
            return "No internet connection."
        case .noData:
            return "No content."
        }
    }
}
