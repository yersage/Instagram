//
//  AppError.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

protocol AppError: Error {
    var description: String { get }
}
