//
//  ImageModel.swift
//  Instagram
//
//  Created by Yersage on 20.01.2022.
//

import Foundation

struct ProfileImageModel: Decodable {
    let image: Data?
}

struct PostImageModel: Decodable {
    let image: Data
}
