//
//  MultipartFormData.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import Foundation

struct FormData {
    var data: Data
    var withName: String
    var fileName: String?
    var mimeType: String?
}
