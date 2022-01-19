//
//  CreatePostPresenter.swift
//  PostFeed
//
//  Created by Yersage on 09.12.2021.
//

import UIKit

final class CreatePostPresenter: CreatePostPresenterDelegate {
    weak var view: CreatePostViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()

    func uploadPost(image: UIImage?, caption: String) {
        guard let image = image else { view?.show(error: "Image is not provided."); return }
        
        if caption == "Write a text..." || caption.isEmpty {
            view?.show(error: "Caption is not provided.")
            return
        }
        
        networkService.upload(context: UploadPostEndPoint(caption: caption, image: image), image: image.pngData()!, caption: caption.data(using: .utf8)!) { result in
            switch result {
            case .success(_):
                self.view?.showSuccess()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
