//
//  FollowersTableViewCell.swift
//  PostFeed
//
//  Created by Yersage on 15.09.2021.
//

import UIKit

struct FollowersState {
    var isFollowing: Bool
    var isRemoved: Bool
}

class FollowersTableViewCell: UITableViewCell {
    
    // MARK:- Initialization
    static let identifier = "FollowersTableViewCell"
    
    var delegate: FollowersTableViewCellDelegate?
    
    lazy var nameIsNotNilConstraints = [
        username.topAnchor.constraint(equalTo: dataStackView.topAnchor),
        name.bottomAnchor.constraint(equalTo: dataStackView.bottomAnchor),
        name.widthAnchor.constraint(equalToConstant: 120)
    ]
    
    lazy var nameIsNilConstraints = [
        username.centerYAnchor.constraint(equalTo: dataStackView.centerYAnchor)
    ]
        
    var followerState: FollowersState?
    
    var followerModel: ProfileModel? {
        didSet {
            if ((followerModel?.user.name) != nil) {
                NSLayoutConstraint.activate(nameIsNotNilConstraints)
                NSLayoutConstraint.deactivate(nameIsNilConstraints)
                name.isHidden = false
            } else {
                NSLayoutConstraint.activate(nameIsNilConstraints)
                NSLayoutConstraint.deactivate(nameIsNotNilConstraints)
            }
            
            guard let userID = followerModel?.user.id else { return }
            profileImageView.loadImagesFromUserID(userID: userID)
            
            if followerState?.isRemoved ?? false {
                removeButton.alpha = 0.5
                removeButton.isEnabled = false
                removeButton.setTitle("Removed", for: .normal)
            }
            
            if ((followerModel?.userMetaData.isFollowedByCurrentUser) != nil) {
                followButton.isHidden = followerModel!.userMetaData.isFollowedByCurrentUser
            }
            
            username.text = followerModel?.user.username
            name.text = followerModel?.user.name
        }
    }
    
    // MARK:- Subviews
    let followerStackView: UIStackView = {
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
        label.text = ""
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.text = ""
        label.isHidden = true
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
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
    
    // MARK:- Init functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(followerStackView)
        
        followerStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        followerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        followerStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        followerStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        dataStackView.addSubview(username)
        dataStackView.addSubview(name)
        
        followerStackView.addSubview(profileImageView)
        followerStackView.addSubview(dataStackView)
        followerStackView.addSubview(followButton)
        followerStackView.addSubview(removeButton)
        
        profileImageView.topAnchor.constraint(equalTo: followerStackView.topAnchor, constant: 10).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: followerStackView.bottomAnchor, constant: -10).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: followerStackView.leftAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dataStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        dataStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        dataStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        username.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        followButton.centerYAnchor.constraint(equalTo: username.centerYAnchor).isActive = true
        followButton.leftAnchor.constraint(equalTo: dataStackView.rightAnchor, constant: 80).isActive = true
        
        removeButton.centerYAnchor.constraint(equalTo: followerStackView.centerYAnchor).isActive = true
        removeButton.rightAnchor.constraint(equalTo: followerStackView.rightAnchor, constant: -10).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        username.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(usernameButtonPressed)))
        followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
    }
}

// MARK:- addTarget functions
extension FollowersTableViewCell {
    @objc func usernameButtonPressed(_ sender: UIButton) {
        delegate?.usernamePressed(self, userID: String(describing: followerModel?.user.id), username: followerModel?.user.username)
    }
    
    @objc func followButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == "Follow" {
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.gray, for: .normal)
            delegate?.followPressed(self)
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.blue, for: .normal)
            delegate?.followPressed(self)
        }
    }
    
    @objc func removeButtonPressed(_ sender: UIButton) {
        removeButton.alpha = 0.5
        removeButton.isEnabled = false
        removeButton.setTitle("Removed", for: .normal)
        delegate?.removePressed(self, postID: nil)
    }
}
