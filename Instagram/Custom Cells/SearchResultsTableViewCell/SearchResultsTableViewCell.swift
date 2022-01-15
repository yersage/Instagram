//
//  SearchResultsTableViewCell.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
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
        
        searchResultStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        searchResultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        searchResultStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        searchResultStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        dataStackView.addSubview(username)
        dataStackView.addSubview(name)
        
        searchResultStackView.addSubview(profileImageView)
        searchResultStackView.addSubview(dataStackView)
        
        profileImageView.topAnchor.constraint(equalTo: searchResultStackView.topAnchor, constant: 10).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: searchResultStackView.bottomAnchor, constant: -10).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: searchResultStackView.leftAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        dataStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        dataStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        dataStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        
        username.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(usernameButtonPressed)))
    }
    
    @objc func usernameButtonPressed(_ sender: UIButton) {
        delegate?.usernamePressed(self)
    }

}
