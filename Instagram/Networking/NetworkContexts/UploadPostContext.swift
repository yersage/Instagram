//
//  UploadPostContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import UIKit

class UploadPostContext: NetworkContext {
    var route: InstagramRoute { return .uploadPost }
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(caption: String, image: UIImage) {
        parameters["caption"] = caption
        parameters["images"] = image
    }
}
