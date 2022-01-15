//
//  PostFeedTableViewCell.swift
//  PostFeed
//
//  Created by Yersage on 10.09.2021.
//

import UIKit

struct PostState {
    var isMorePressed: Bool
    var isSavePressed: Bool
}

// MARK:- addTarget functions
extension PostTableViewCell {
    
    @objc private func moreButtonPressed(sender: UIButton) {
        DispatchQueue.main.async { [self] in
            postCaptionLabel.numberOfLines = 0
            captionMoreButton.isHidden = false
        }
        feedTableViewCellDelegate?.morePressed(self)
    }
    
    @objc private func likeButtonPressed(sender: UIButton) {
        guard let postModel = postModel else { return }
        DispatchQueue.main.async { [self] in
            if likePostImageView.tintColor == .red {
                howManyLikesLabel.text = "\(postModel.post.numberOfLikes == 0 ? 0 : postModel.post.numberOfLikes - 1) Likes"
                likePostImageView.tintColor = .black
                feedTableViewCellDelegate?.unlikePressed(self, postID: postModel.post.id)
            } else {
                howManyLikesLabel.text = "\(postModel.post.numberOfLikes + 1) Likes"
                likePostImageView.tintColor = .red
                feedTableViewCellDelegate?.likePressed(self, postID: postModel.post.id)
            }
        }
    }
    
    @objc private func saveButtonPressed(sender: UIButton) {
        DispatchQueue.main.async { [self] in
            if savePostImageView.tintColor == .red {
                savePostImageView.tintColor = .black
            } else {
                savePostImageView.tintColor = .red
            }
        }
        feedTableViewCellDelegate?.savePressed(self)
    }
    
    @objc private func usernameButtonPressed(sender: UIButton) {
        feedTableViewCellDelegate?.usernamePressed(self)
    }
    
    @objc private func commentButtonPressed(sender: UIButton) {
        feedTableViewCellDelegate?.commentPressed(self, postID: postModel?.post.id ?? 0)
    }
}

class PostTableViewCell: UITableViewCell {
    
    // MARK:- Initalization
    static let identifier = "PostTableViewCell"
    
    weak var feedTableViewCellDelegate: PostTableViewCellDelegate?
    
    var postState: PostState?
    
    // MARK:- didSet
    var postModel: PostModel? {
        didSet {
            guard let postModel = postModel else { return }
            guard let postState = postState else { return }
            
            let postID = postModel.post.id
            postImageView.loadImagesFromPostID(postID: postID)
            
            let userID = postModel.post.user.id
            profileImageView.loadImagesFromUserID(userID: userID)
            
            usernameLabel.text = postModel.post.user.username
            
            if postState.isMorePressed {
                postCaptionLabel.numberOfLines = 0
                captionMoreButton.isHidden = true
            }
            
            if postModel.postMetaData.isPostLikedByCurrentUser {
                likePostImageView.tintColor = .red
            }
            
            if postState.isSavePressed {
                savePostImageView.tintColor = .red
            }
            
            let text = "\(postModel.post.user.username) \(postModel.post.caption)"
            postCaptionLabel.text = text
            let underlineAttrString = NSMutableAttributedString(string: text)
            let range1 = (text as NSString).range(of: "\(postModel.post.caption)")
            underlineAttrString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: range1)
            underlineAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
            postCaptionLabel.attributedText = underlineAttrString
            
            if calculateCaptionLines() <= 2 {
                captionMoreButton.isHidden = true
            }
            
            howManyLikesLabel.text = "\(postModel.post.numberOfLikes) Likes"
            howManyCommentsLabel.text = "View all \(postModel.post.numberOfComments) comments"
            dateOfCreationLabel.text = postModel.post.created
        }
    }
    
    private func calculateCaptionLines() -> Int {
        let maxSize = CGSize(width: postCaptionLabel.frame.size.width, height: CGFloat(Float.infinity))
        let charSize = UIFont.systemFont(ofSize: 12).lineHeight
        let text = (postCaptionLabel.text)! as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    // MARK:- Lifecycle functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionMoreButton.isHidden = false
        postCaptionLabel.numberOfLines = 2
        likePostImageView.tintColor = .black
        savePostImageView.tintColor = .black
        usernameLabel.text = ""
        postCaptionLabel.text = ""
        howManyLikesLabel.text = ""
        howManyCommentsLabel.text = ""
        dateOfCreationLabel.text = ""
    }
    
    // MARK:- Header Layouts
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = .gray
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let profileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    // MARK:- Post Content Layouts
    
    let postView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- Post Image Layouts
    
    let postImageView: CachedImageView = {
        let postImageView = CachedImageView()
        postImageView.layer.masksToBounds = false
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return postImageView
    }()
    
    // MARK:- Like, Comment, Save Button Layouts
    
    let postButtonsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let likePostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let likePostImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "heart"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    
    let commentPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentPostImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "message"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    
    let savePostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let savePostImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "bookmark"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    
    // MARK:- N Likes Layouts
    
    let howManyLikesView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let howManyLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK:- Caption Layouts
    
    let postCaptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postCaptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 11)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let captionMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("more", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return button
    }()
    
    // MARK:- N Comments Layouts
    
    let howManyCommentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let howManyCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK:- Date of Creation Layouts
    
    let dateOfCreationView: UIView = {
        let view = UIView()
        return view
    }()
    
    let dateOfCreationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK:- Layout
    
    func layout() {
        layoutHeader()
        layoutBody()
    }
    
    func layoutHeader() {
        
        headerStackView.addSubview(profileImageView)
        headerStackView.addSubview(profileImageButton)
        headerStackView.addSubview(usernameLabel)
        headerStackView.addSubview(usernameButton)
        
        contentView.addSubview(headerStackView)
        
        headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        headerStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        profileImageView.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        profileImageButton.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        profileImageButton.leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
        profileImageButton.rightAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        profileImageButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        
        usernameLabel.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 5).isActive = true
        
        usernameButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        usernameButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        usernameButton.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor).isActive = true
        usernameButton.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
    }
    
    func layoutBody() {
        setupImage()
        setupButtons()
        setupLikesCount()
        setupCaption()
        setupComments()
        setupDateOfPostsCreation()
        setupButtonFunctionalities()
    }
    
    func setupImage() {
        contentView.addSubview(postImageView)
        
        postImageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor).isActive = true
        postImageView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor).isActive = true
        postImageView.rightAnchor.constraint(equalTo: headerStackView.rightAnchor).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func setupButtons() {
        postButtonsStackView.addSubview(likePostImageView)
        postButtonsStackView.addSubview(likePostButton)
        postButtonsStackView.addSubview(commentPostImageView)
        postButtonsStackView.addSubview(commentPostButton)
        postButtonsStackView.addSubview(savePostImageView)
        postButtonsStackView.addSubview(savePostButton)
        
        contentView.addSubview(postButtonsStackView)
        
        postButtonsStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor).isActive = true
        postButtonsStackView.leftAnchor.constraint(equalTo: postImageView.leftAnchor).isActive = true
        postButtonsStackView.rightAnchor.constraint(equalTo: postImageView.rightAnchor).isActive = true
        postButtonsStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        likePostImageView.centerYAnchor.constraint(equalTo: postButtonsStackView.centerYAnchor).isActive = true
        likePostImageView.leftAnchor.constraint(equalTo: postButtonsStackView.leftAnchor).isActive = true
        likePostImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        likePostImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        likePostButton.topAnchor.constraint(equalTo: likePostImageView.topAnchor).isActive = true
        likePostButton.leftAnchor.constraint(equalTo: likePostImageView.leftAnchor).isActive = true
        likePostButton.rightAnchor.constraint(equalTo: likePostImageView.rightAnchor).isActive = true
        likePostButton.bottomAnchor.constraint(equalTo: likePostImageView.bottomAnchor).isActive = true
        
        commentPostImageView.centerYAnchor.constraint(equalTo: postButtonsStackView.centerYAnchor).isActive = true
        commentPostImageView.leftAnchor.constraint(equalTo: likePostButton.rightAnchor, constant: 5).isActive = true
        commentPostImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        commentPostImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        commentPostButton.topAnchor.constraint(equalTo: commentPostImageView.topAnchor).isActive = true
        commentPostButton.leftAnchor.constraint(equalTo: commentPostImageView.leftAnchor).isActive = true
        commentPostButton.rightAnchor.constraint(equalTo: commentPostImageView.rightAnchor).isActive = true
        commentPostButton.bottomAnchor.constraint(equalTo: commentPostImageView.bottomAnchor).isActive = true
        
        savePostImageView.centerYAnchor.constraint(equalTo: postButtonsStackView.centerYAnchor).isActive = true
        savePostImageView.rightAnchor.constraint(equalTo: postButtonsStackView.rightAnchor).isActive = true
        savePostImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        savePostImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        savePostButton.topAnchor.constraint(equalTo: savePostImageView.topAnchor).isActive = true
        savePostButton.leftAnchor.constraint(equalTo: savePostImageView.leftAnchor).isActive = true
        savePostButton.rightAnchor.constraint(equalTo: savePostImageView.rightAnchor).isActive = true
        savePostButton.bottomAnchor.constraint(equalTo: savePostImageView.bottomAnchor).isActive = true
    }
    
    func setupLikesCount() {
        contentView.addSubview(howManyLikesLabel)
        
        howManyLikesLabel.topAnchor.constraint(equalTo: postButtonsStackView.bottomAnchor).isActive = true
        howManyLikesLabel.leftAnchor.constraint(equalTo: postButtonsStackView.leftAnchor).isActive = true
        howManyLikesLabel.rightAnchor.constraint(equalTo: postButtonsStackView.rightAnchor).isActive = true
        howManyLikesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupCaption() {
        contentView.addSubview(postCaptionLabel)
        contentView.addSubview(captionMoreButton)
        
        postCaptionLabel.topAnchor.constraint(equalTo: howManyLikesLabel.bottomAnchor).isActive = true
        postCaptionLabel.leftAnchor.constraint(equalTo: howManyLikesLabel.leftAnchor).isActive = true
        postCaptionLabel.rightAnchor.constraint(equalTo: howManyLikesLabel.rightAnchor, constant: -30).isActive = true
        
        captionMoreButton.rightAnchor.constraint(equalTo: howManyLikesLabel.rightAnchor).isActive = true
        captionMoreButton.bottomAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 1).isActive = true
        captionMoreButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    func setupComments() {
        contentView.addSubview(howManyCommentsLabel)
        
        howManyCommentsLabel.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor).isActive = true
        howManyCommentsLabel.leftAnchor.constraint(equalTo: postCaptionLabel.leftAnchor).isActive = true
        howManyCommentsLabel.rightAnchor.constraint(equalTo: postCaptionLabel.rightAnchor).isActive = true
        howManyCommentsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupDateOfPostsCreation() {
        contentView.addSubview(dateOfCreationLabel)
        
        dateOfCreationLabel.topAnchor.constraint(equalTo: howManyCommentsLabel.bottomAnchor).isActive = true
        dateOfCreationLabel.leftAnchor.constraint(equalTo: howManyCommentsLabel.leftAnchor).isActive = true
        dateOfCreationLabel.rightAnchor.constraint(equalTo: howManyCommentsLabel.rightAnchor).isActive = true
        dateOfCreationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupButtonFunctionalities() {
        likePostButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        savePostButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        captionMoreButton.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
        profileImageButton.addTarget(self, action: #selector(usernameButtonPressed), for: .touchUpInside)
        usernameButton.addTarget(self, action: #selector(usernameButtonPressed), for: .touchUpInside)
        commentPostButton.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
    }
}
