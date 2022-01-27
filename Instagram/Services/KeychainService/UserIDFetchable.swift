//
//  UserIDFetchable.swift
//  Instagram
//
//  Created by Yersage on 27.01.2022.
//

import Foundation

protocol UserIDFetchable {
    func fetchUserID(from token: String) -> String?
}
