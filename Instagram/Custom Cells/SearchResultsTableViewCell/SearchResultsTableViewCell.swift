//
//  SearchResultsTableViewCell.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import UIKit

final class SearchResultsTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultsTableViewCell"
    var delegate: SearchResultsTableViewCellDelegate?
    
    let searchResultStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
        
    var profileModel: ProfileModel? {
        didSet {
            guard let userID = profileModel?.user.id else { return }
            profileImageView.loadImagesFromUserID(userID: userID)
            
            if ((profileModel?.user.name) != nil) {
                username.topAnchor.constraint(equalTo: dataStackView.topAnchor).isActive = true
                name.bottomAnchor.constraint(equalTo: dataStackView.bottomAnchor).isActive = true
                name.isHidden = false
            } else {
                username.centerYAnchor.constraint(equalTo: dataStackView.centerYAnchor).isActive = true
            }
            username.text = profileModel?.user.username
            name.text = profileModel?.user.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(searchResultStackView)
        
        NSLayoutConstraint.activate([
            searchResultStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchResultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            searchResultStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            searchResultStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            profileImageView.topAnchor.constraint(equalTo: searchResultStackView.topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: searchResultStackView.bottomAnchor, constant: -10),
            profileImageView.leftAnchor.constraint(equalTo: searchResultStackView.leftAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            dataStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            dataStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            dataStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10)
        ])
        
        dataStackView.addSubview(username)
        dataStackView.addSubview(name)
        
        searchResultStackView.addSubview(profileImageView)
        searchResultStackView.addSubview(dataStackView)

        username.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(usernameButtonPressed)))
    }
    
    @objc func usernameButtonPressed(_ sender: UIButton) {
        delegate?.usernamePressed(self)
    }

}
