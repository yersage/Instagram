//
//  IndicatorCell.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import UIKit

final class LoaderCell: UICollectionViewCell {
    
    static let identifier = "loader"
    
    var loader : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        loader.startAnimating()
    }
}
