//
//  CommentTableViewCell.swift
//  PostFeed
//
//  Created by Yersage on 17.09.2021.
//

import UIKit

protocol ReplyDelegate: AnyObject {
    func replyButtonPressed(_ cell: CommentTableViewCell)
}

protocol ViewRepliesDelegate: AnyObject {
    func viewReplies(_ cell: CommentTableViewCell)
}

protocol LikeCommentDelegate: AnyObject {
    func likeComment(_ cell: CommentTableViewCell)
}

protocol UsernameDelegate: AnyObject {
    func goToUsername(_ cell: CommentTableViewCell)
}

final class CommentTableViewCell: UITableViewCell {
    
    let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK:- 1st column
    
    let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image"))
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
    
    let profileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    // MARK:- 2nd column
    
    let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let commentsContentLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    let contentFooterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let dateOfCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "12 Likes"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let howManyLikesLabel: UILabel = {
        let label = UILabel()
        label.text = "12 Likes"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let replyLabel: UILabel = {
        let label = UILabel()
        label.text = "Reply"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let replyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    // MARK:- 3rd column
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    let likeImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "heart"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    
    // MARK:- Reply Footer
    let replyFooterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let replyFooterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.isEnabled = true
        return button
    }()
    
    // MARK:- Initialization
    
    static let identifier = "CommentTableViewCell"
    
    weak var likeDelegate: LikeCommentDelegate?
    weak var viewRepliesDelegate: ViewRepliesDelegate?
    weak var replyDelegate: ReplyDelegate?
    weak var usernameDelegate: UsernameDelegate?
    
    var isLikeButtonPressed: Bool = false
    var isViewRepliesButtonPressed: Bool = false
    
    var tokenModel: TokenModel?
    
    var commentModel: CommentModel? {
        didSet {
            guard let commentModel = commentModel else { print("From CommentTableViewCell didSet: commentModel is nil."); return }
            
//            getProfileImage(userID: commentModel.commentProjection.authorId)
            
            dateOfCommentLabel.text = commentModel.commentProjection.created
            howManyLikesLabel.text = "\(commentModel.commentProjection.numberOfLikes) Likes"
            
            if isLikeButtonPressed {
                likeImageView.tintColor = .red
            }
            
            if commentModel.commentProjection.repliedToComment != nil {
                let text = commentModel.commentProjection.author + " @" + commentModel.commentProjection.repliedToComment!.author + " " + commentModel.commentProjection.content
                commentsContentLabel.text = text
                
                let replyAttrString = NSMutableAttributedString(string: text)
                let range1 = (text as NSString).range(of: commentModel.commentProjection.content)
                replyAttrString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: range1)
                replyAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
                
                let range2 = (text as NSString).range(of: " @" + commentModel.commentProjection.repliedToComment!.author)
                replyAttrString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: range2)
                replyAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
                commentsContentLabel.attributedText = replyAttrString
            } else {
                let text = commentModel.commentProjection.author + " " + commentModel.commentProjection.content
                commentsContentLabel.text = text
                let underlineAttrString = NSMutableAttributedString(string: text)
                let range1 = (text as NSString).range(of: commentModel.commentProjection.content)
                underlineAttrString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: range1)
                underlineAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
                commentsContentLabel.attributedText = underlineAttrString
            }
            
            if commentModel.commentProjection.parentComment != nil {
                profileImage.leftAnchor.constraint(equalTo: horizontalStack.leftAnchor, constant: 35).isActive = true
            } else {
                profileImage.leftAnchor.constraint(equalTo: horizontalStack.leftAnchor, constant: 10).isActive = true
            }
            
            if commentModel.commentProjection.numberOfChildrenComments == 0 {
                replyFooterLabel.isHidden = true
                replyFooterButton.isHidden = true
                return
            }
                        
            if !isViewRepliesButtonPressed {
                replyFooterLabel.text = "View \(commentModel.commentProjection.numberOfChildrenComments) replies"
                replyFooterLabel.isHidden = false
                replyFooterButton.isHidden = false
            } else {
                replyFooterLabel.text = "Hide replies"
            }
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
        
        contentView.addSubview(horizontalStack)
        
        horizontalStack.addSubview(profileImage)
        horizontalStack.addSubview(profileImageButton)
        horizontalStack.addSubview(contentStack)
        horizontalStack.addSubview(likeImageView)
        horizontalStack.addSubview(likeButton)
        
        contentStack.addSubview(commentsContentLabel)
        contentStack.addSubview(usernameButton)
        contentStack.addSubview(dateOfCommentLabel)
        contentStack.addSubview(contentFooterStack)
        contentStack.addSubview(replyFooterLabel)
        contentStack.addSubview(replyFooterButton)
        
        contentFooterStack.addSubview(howManyLikesLabel)
        contentFooterStack.addSubview(replyLabel)
        contentFooterStack.addSubview(replyButton)
        
        layout1stColumn()
        layout2ndColumn()
        layout3rdColumn()
    }
    
    func layout1stColumn() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: horizontalStack.topAnchor, constant: 5),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            profileImageButton.topAnchor.constraint(equalTo: profileImage.topAnchor),
            profileImageButton.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            profileImageButton.rightAnchor.constraint(equalTo: profileImage.rightAnchor),
            profileImageButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor)
        ])
        
        profileImageButton.addTarget(self, action: #selector(UsernameButtonPressed), for: .touchUpInside)
    }
    
    func layout2ndColumn() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: horizontalStack.topAnchor, constant: 5),
            contentStack.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
            contentStack.rightAnchor.constraint(equalTo: likeImageView.leftAnchor, constant: -10),
            contentStack.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor),
            commentsContentLabel.topAnchor.constraint(equalTo: contentStack.topAnchor),
            commentsContentLabel.leftAnchor.constraint(equalTo: contentStack.leftAnchor),
            commentsContentLabel.rightAnchor.constraint(equalTo: contentStack.rightAnchor),
            usernameButton.topAnchor.constraint(equalTo: commentsContentLabel.topAnchor),
            usernameButton.leftAnchor.constraint(equalTo: commentsContentLabel.leftAnchor),
            dateOfCommentLabel.topAnchor.constraint(equalTo: commentsContentLabel.bottomAnchor),
            replyFooterLabel.topAnchor.constraint(equalTo: dateOfCommentLabel.bottomAnchor, constant: 10),
            replyFooterLabel.centerXAnchor.constraint(equalTo: contentStack.centerXAnchor),
            replyFooterLabel.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: -5),
            replyFooterButton.leftAnchor.constraint(equalTo: replyFooterLabel.leftAnchor),
            replyFooterButton.rightAnchor.constraint(equalTo: replyFooterLabel.rightAnchor),
            replyFooterButton.bottomAnchor.constraint(equalTo: replyFooterLabel.bottomAnchor),
            contentFooterStack.topAnchor.constraint(equalTo: commentsContentLabel.bottomAnchor),
            contentFooterStack.leftAnchor.constraint(equalTo: contentStack.leftAnchor),
            contentFooterStack.rightAnchor.constraint(equalTo: contentStack.rightAnchor),
            contentFooterStack.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor),
            howManyLikesLabel.leftAnchor.constraint(equalTo: dateOfCommentLabel.rightAnchor, constant: 10),
            replyLabel.leftAnchor.constraint(equalTo: howManyLikesLabel.rightAnchor, constant: 10),
            replyButton.leftAnchor.constraint(equalTo: replyLabel.leftAnchor)
        ])
        
        usernameButton.addTarget(self, action: #selector(UsernameButtonPressed), for: .touchUpInside)
        replyFooterButton.addTarget(self, action: #selector(ViewRepliesButtonPressed), for: .touchUpInside)
        replyButton.addTarget(self, action: #selector(ReplyButtonPressed), for: .touchUpInside)
    }
    
    func layout3rdColumn() {
        NSLayoutConstraint.activate([
            likeImageView.topAnchor.constraint(equalTo: horizontalStack.topAnchor, constant: 5),
            likeImageView.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor, constant: -10),
            likeImageView.widthAnchor.constraint(equalToConstant: 20),
            likeImageView.heightAnchor.constraint(equalToConstant: 20),
            likeButton.topAnchor.constraint(equalTo: likeImageView.topAnchor),
            likeButton.rightAnchor.constraint(equalTo: likeImageView.rightAnchor),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            horizontalStack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        likeButton.addTarget(self, action: #selector(LikeButtonPressed), for: .touchUpInside)
    }
    
    @objc func UsernameButtonPressed() {
        print("go to \(String(describing: commentModel?.commentProjection.author))")
        usernameDelegate?.goToUsername(self)
        
    }
    
    @objc func ReplyButtonPressed() {
        print("reply to comment")
//        tableView.scrollToRowAtIndexPath
        replyDelegate?.replyButtonPressed(self)
    }
    
    @objc func ViewRepliesButtonPressed() {
        print("show me replies")
        viewRepliesDelegate?.viewReplies(self)
    }
    
    @objc func LikeButtonPressed() {
        if likeImageView.tintColor == .black {
            likeImageView.tintColor = .red
            print("Like tomu chuvaku")
        } else {
            likeImageView.tintColor = .black
            print("Unlike tomu chuvaku")
        }
        likeDelegate?.likeComment(self)
    }
}
