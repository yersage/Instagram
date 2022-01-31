//
//  CreatePostPresenter.swift
//  PostFeed
//
//  Created by Yersage on 09.12.2021.
//

import UIKit

final class CreatePostPresenter: CreatePostPresenterDelegate {
    weak var view: CreatePostViewDelegate?
    private let createPostService = CreatePostService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))

    func uploadPost(image: UIImage?, caption: String) {
        guard let image = image else { view?.show(error: "Image is not provided."); return }
        
        if caption == "Write a text..." || caption.isEmpty {
            view?.show(error: "Caption is not provided.")
            return
        }
        
        guard let caption = caption.data(using: .utf8) else { return }
        guard let image = image.pngData() else { return }
        
        createPostService.uploadPost(caption: caption, images: image) { result in
            switch result {
            case .success(_):
                self.view?.showSuccess()
                self.view?.goToFeedVC()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}
