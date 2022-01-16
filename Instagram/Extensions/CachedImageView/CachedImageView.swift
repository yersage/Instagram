//
//  CachedImageView.swift
//  PostFeed
//
//  Created by Yersage on 01.11.2021.
//

import UIKit

class CachedImageView: UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()
    private let networkService: NetworkService = NetworkAdapter()
    
    private var imageURLString: String?
    
    func loadImagesFromPostID(postID: Int, completion: ((Result<UIImage?, Error>) -> Void)? = defaultCompletion(CachedImageView())) {
        
        let urlString = InstagramAPI.postImages(postID: "\(postID)").urlString()
        imageURLString = urlString
        
        if let imageFromCache = CachedImageView.imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            return
        }
        
        networkService.loadImage(context: ProfilePostEndPoint(postID: "\(postID)")) { result in
            switch result {
            case .success(let newImage):
                CachedImageView.imageCache.setObject(newImage, forKey: ProfilePostEndPoint(postID: "\(postID)").path.urlString() as NSString)
                self.defaultCompletion(result: .success(newImage))
                let imageToCache = newImage
                DispatchQueue.main.async {
                    if self.imageURLString == urlString {
                        self.image = imageToCache
                    }
                }
                CachedImageView.imageCache.setObject(newImage, forKey: urlString as NSString)
            case .failure(_):
                self.defaultCompletion(result: .success(nil))
            }
        }
    }
    
    func loadImagesFromUserID(userID: Int, completion: ((Result<UIImage?, Error>) -> Void)? = defaultCompletion(CachedImageView())) {
        let urlString = InstagramAPI.profileImage(userID: "\(userID)").urlString()
        imageURLString = urlString
        
        if let imageFromCache = CachedImageView.imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            return
        }
        
        networkService.loadImage(context: ProfileImageEndPoint(userID: "\(userID)")) { result in
            switch result {
            case .success(let newImage):
                CachedImageView.imageCache.setObject(newImage, forKey: ProfileImageEndPoint(userID: "\(userID)").path.urlString() as NSString)
                self.defaultCompletion(result: .success(newImage))
                let imageToCache = newImage
                DispatchQueue.main.async {
                    if self.imageURLString == urlString {
                        self.image = imageToCache
                    }
                }
                CachedImageView.imageCache.setObject(newImage, forKey: urlString as NSString)
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
