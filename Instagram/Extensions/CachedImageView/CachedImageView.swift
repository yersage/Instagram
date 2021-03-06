//
//  CachedImageView.swift
//  PostFeed
//
//  Created by Yersage on 01.11.2021.
//

import UIKit

class CachedImageView: UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()
    private let imageService = ImageService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))
    
    private var imageURLString: String?
    
    func loadImagesFromPostID(postID: Int, completion: ((Result<UIImage?, Error>) -> Void)? = defaultCompletion(CachedImageView())) {
        
        let urlString = InstagramEndPoint.postImage(postID: postID).baseURL + InstagramEndPoint.postImage(postID: postID).path
        imageURLString = urlString
        
        if let imageFromCache = CachedImageView.imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            return
        }
        
        imageService.getPostImage(postID: postID) { result in
            switch result {
            case .success(let postImageData):
                let path = InstagramEndPoint.postImage(postID: postID).baseURL + InstagramEndPoint.postImage(postID: postID).path
                guard let image = UIImage(data: postImageData) else { self.defaultCompletion(result: .success(nil)); return }
                CachedImageView.imageCache.setObject(image, forKey: path as NSString)
                self.defaultCompletion(result: .success(image))
                let imageToCache = image
                DispatchQueue.main.async {
                    if self.imageURLString == urlString {
                        self.image = imageToCache
                    }
                }
                CachedImageView.imageCache.setObject(image, forKey: urlString as NSString)
            case .failure(_):
                self.defaultCompletion(result: .success(nil))
            }
        }
    }
    
    func loadImagesFromUserID(userID: Int, completion: ((Result<UIImage?, Error>) -> Void)? = defaultCompletion(CachedImageView())) {
        let urlString = InstagramEndPoint.profileImage(userID: userID).baseURL + InstagramEndPoint.profileImage(userID: userID).path
        imageURLString = urlString
        
        if let imageFromCache = CachedImageView.imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            return
        }
        
        imageService.getProfileImage(userID: userID) { result in
            switch result {
            case .success(let profileImageData):
                let urlString = InstagramEndPoint.profileImage(userID: userID).baseURL + InstagramEndPoint.profileImage(userID: userID).path
                guard let image = UIImage(data: profileImageData) else { return }
                CachedImageView.imageCache.setObject(image, forKey: urlString as NSString)
                self.defaultCompletion(result: .success(image))
                let imageToCache = image
                DispatchQueue.main.async {
                    if self.imageURLString == urlString {
                        self.image = imageToCache
                    }
                }
                CachedImageView.imageCache.setObject(image, forKey: urlString as NSString)
            case .failure(_):
                self.defaultCompletion(result: .success(nil))
            }
        }
    }
    
    func defaultCompletion(result: Result<UIImage?, Error>) {
        switch result {
        case .success(let image):
            if image != nil {
                self.image = image
            } else {
                self.image = UIImage(named: "image")
            }
        case .failure(let error):
            print("Somehow process error, \(error)")
        }
    }
}
