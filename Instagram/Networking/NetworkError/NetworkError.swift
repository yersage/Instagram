//
//  NetworkError.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

enum NetworkError: AppError {
    
    case dataLoad
    case unknown
    case noConnection
    case urlValid
    case noData
    case invalidParameters
    case alreadyCreated
    
    var description: String {
        switch self {
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
        case .alreadyCreated:
            return "Provided parameter already exists."
        }
    }
}
