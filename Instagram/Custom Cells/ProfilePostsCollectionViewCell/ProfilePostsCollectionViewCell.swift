//
//  ProfilePostsCollectionViewCell.swift
//  PostFeed
//
//  Created by Yersage on 15.09.2021.
//

import UIKit

final class ProfilePostsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: CachedImageView!
    
    static let identifier = "ProfilePostsCollectionViewCell"
    
    var postID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with postID: Int) {
        self.postID = postID
        imageView.loadImagesFromPostID(postID: postID)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfilePostsCollectionViewCell", bundle: nil)
    }
}
