//
//  FollowingTableViewCell.swift
//  PostFeed
//
//  Created by Yersage on 15.09.2021.
//

import UIKit

struct FollowingState {
    var isFollowing: Bool
}

final class FollowingTableViewCell: UITableViewCell {
    
    static let identifier = "FollowingTableViewCell"
    var delegate: FollowingTableViewCellDelegate?
    
    let followingStackView: UIStackView = {
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
        let imageView = CachedImageView(image: UIImage(named: "image"))
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
        label.text = "yersage"
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
        label.text = "Canagat"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        button.layer.cornerRadius = button.frame.size.height / 5
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isFollowing: Bool = false
    
    private var followingModel: ProfileModel?
    
    func set(_ followingModel: ProfileModel) {
        profileImageView.loadImagesFromUserID(userID: followingModel.user.id)
        
        if followingModel.user.name != nil {
            username.topAnchor.constraint(equalTo: dataStackView.topAnchor).isActive = true
            name.bottomAnchor.constraint(equalTo: dataStackView.bottomAnchor).isActive = true
            name.isHidden = false
        } else {
            username.centerYAnchor.constraint(equalTo: dataStackView.centerYAnchor).isActive = true
        }
        
        if !isFollowing {
            followingButton.setTitle("Follow", for: .normal)
            followingButton.backgroundColor = .blue
            followingButton.tintColor = .white
        }
        
        username.text = followingModel.user.username
        name.text = followingModel.user.name
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(followingStackView)
        NSLayoutConstraint.activate([
            followingStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            followingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            followingStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            followingStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        dataStackView.addSubview(username)
        dataStackView.addSubview(name)
        
        followingStackView.addSubview(profileImageView)
        followingStackView.addSubview(dataStackView)
        followingStackView.addSubview(followingButton)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: followingStackView.topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: followingStackView.bottomAnchor, constant: -10),
            profileImageView.leftAnchor.constraint(equalTo: followingStackView.leftAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            dataStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            dataStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            dataStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10),
            dataStackView.rightAnchor.constraint(equalTo: followingButton.leftAnchor, constant: -10),
            followingButton.centerYAnchor.constraint(equalTo: followingStackView.centerYAnchor),
            followingButton.rightAnchor.constraint(equalTo: followingStackView.rightAnchor, constant: -10),
            followingButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        username.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(usernameButtonPressed)))
        followingButton.addTarget(self, action: #selector(followingButtonPressed), for: .touchUpInside)
    }
    
    @objc func usernameButtonPressed(_ sender: UIButton) {
        delegate?.usernamePressed(self, userID: String(describing: followingModel?.user.id), username: followingModel?.user.username)
    }
    
    @objc func followingButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == "Following" {
            followingButton.setTitle("Follow", for: .normal)
            followingButton.backgroundColor = .blue
            followingButton.setTitleColor(.white, for: .normal)
            delegate?.unfollow()
        } else {
            followingButton.setTitle("Following", for: .normal)
            followingButton.layer.borderColor = UIColor.black.cgColor
            followingButton.backgroundColor = .clear
            followingButton.setTitleColor(.black, for: .normal)
            print("Now you are following this account.")
            delegate?.follow()
        }
    }
}
