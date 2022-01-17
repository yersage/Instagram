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
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        loader.startAnimating()
    }
}
