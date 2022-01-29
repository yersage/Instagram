//
//  TokenService.swift
//  Instagram
//
//  Created by Yersage on 29.01.2022.
//

import Foundation

protocol TokenServiceDelegate {
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
}
