//
//  CommentsViewController.swift
//  PostFeed
//
//  Created by Yersage on 16.09.2021.
//

import UIKit

struct CommentState {
    var isLikePressed: Bool
    var isViewReplyPressed: Bool
}

struct ReplyState {
    var isShowing: Bool
    var page: Int
}

final class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    var tokenModel: TokenModel?
    var postID: Int?
    var userID: Int?
    
    var page = 0
    var isPaginating: Bool = false
    var numberOfComments: Int?
    
    var comments: [CommentModel] = []
    var commentImages: [UIImage] = []
    var commentState: [CommentState] = []
    var commentsWithReplies: [Int: ReplyState] = [:]
    
    var clearText: String = ""
    var commentIdOfBeingReplied: Int?
    /*
    private let presenter: PasswordPresenterDelegate
    
    init?(presenter: PasswordPresenterDelegate, coder: NSCoder) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(product:coder:)")
    required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
//        downloadProfileImage()
        
//        getComments()
    }
    
    func layout() {
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = 15
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        commentsTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.separatorStyle = .none
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        if commentTextField.text == "" || commentTextField.text == clearText { print("From CommentsVC postButtonPressed: textField is empty."); return }
        if commentTextField.text?.first == "@" {
//            postComment(content: commentTextField.text!, commentID: commentIdOfBeingReplied)
            print("Reply to comment")
        } else {
//            postComment(content: commentTextField.text!, commentID: nil)
            print("Comment")
        }
    }
}

// MARK:- Get Profile Image
extension CommentsViewController {
//    func getProfileImage() {
//        let profileImageRequest = URLRequests.profileImage(with: tokenModel?.accessToken ?? "", userID: "\(userID ?? -1)")
//        downloadProfileImage(with: profileImageRequest)
//    }
//
//    func downloadProfileImage(with request: URLRequest) {
//        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
//
//            var statusCode = 403
//
//            if let httpResponse = response as? HTTPURLResponse {
//                statusCode = httpResponse.statusCode
//            }
//
//            if statusCode != 200 && statusCode != 204 {
//                print("Problem getting profile image")
//                print(response ?? "No response at all.")
//                return
//            }
//            if statusCode == 204 {
//                print("From CommentsVC downloadProfileImage: no profile image.")
//                return
//            }
//
//            guard let safeData = data else { print("From CommentsVC downloadProfileImage: data is nil."); return }
//            guard let safeImage = UIImage(data: safeData) else { print("From CommentsVC downloadProfileImage: couldn't take image from data."); return }
//
//            DispatchQueue.main.async {
//                profileImageView.image = safeImage
//            }
//
//        }.resume()
//    }
}

// MARK:- Post Comment
extension CommentsViewController {
//
//    func postComment(content: String, commentID: Int?) {
//        guard let postID = postID else { print("From CommentsVC getComments: postID is nil."); return }
//        let request = URLRequests.postComment(accessToken: tokenModel?.accessToken ?? "", postID: postID, commentID: commentID, content: content)
//        requestPostComment(with: request)
//    }
//
//    func requestPostComment(with request: URLRequest) {
//        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
//
//            guard let httpResponse = response as? HTTPURLResponse else { print("From Comments requestPostComment: couldn't get response's status code."); return }
//            guard let safeData = data else { print("From CommentsVC requestPostComment: data is nil."); return }
//
//            if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
//                print("From CommentsVC requestPostComment: response is not 200.")
//                print(response ?? "No response at all.")
//            }
//            if httpResponse.statusCode == 204 {
//                print("From CommentsVC requestPostComment: no content.")
//                return
//            }
//
//            fetchPostedComment(from: safeData)
//
//        }.resume()
//    }
//
//    func fetchPostedComment(from answer: Data) {
//        do {
//            let decodedData = try JSONDecoder().decode(CommentModel.self, from: answer)
//
//            comments.append(decodedData)
//            commentState.append(CommentState(isLikePressed: false, isViewReplyPressed: false))
//            commentImages.append(UIImage())
//
//            DispatchQueue.main.async { [self] in
//                commentTextField.text = ""
//                getComments()
//                //                commentsTableView.reloadData()
//            }
//
//        } catch {
//            print(error)
//        }
//    }
}

// MARK:- UITableViewDataSource
extension CommentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if comments[indexPath.row].commentProjection.parentComment != nil {
            if !commentsWithReplies[comments[indexPath.row].commentProjection.parentComment!.id]!.isShowing {
                return 0
            }
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if comments.count == 0 {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as? CommentTableViewCell else { print("CommentsVC cellForRowAt: Error dequeuing cell."); return UITableViewCell() }
        
        let comment = comments[indexPath.row]
        
        //        if comment.commentProjection.parentComment != nil {
        //            if !commentsWithReplies[comments[indexPath.row].commentProjection.id]!.isShowing {
        //                cell.isHidden = true
        //            }
        //        }
        
        //        cell.likeDelegate  = self
        cell.usernameDelegate = self
        cell.viewRepliesDelegate = self
        cell.replyDelegate = self
        
        if commentsWithReplies[comments[indexPath.row].commentProjection.id]?.isShowing != nil {
            cell.isViewRepliesButtonPressed = commentsWithReplies[comments[indexPath.row].commentProjection.id]!.isShowing
        }
        
        cell.isLikeButtonPressed = comment.commentMetaData.isCommentLikedByCurrentUser
        cell.tokenModel = tokenModel
        cell.commentModel = comment
        
        return cell
    }
}

// MARK:- Get Comments Data
extension CommentsViewController {
    
//    func getComments() {
//        if isPaginating { return }
//        if postID == nil { print("From CommentsVC getComments: postID is nil."); return }
//
//        let request = URLRequests.comments(accessToken: tokenModel?.accessToken ?? "", postID: postID!, page: page)
//        isPaginating = true
//        requestComments(with: request)
//    }
//
//    func requestComments(with request: URLRequest) {
//        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
//
//            guard let httpResponse = response as? HTTPURLResponse else { print("From Comments requestComments: couldn't get response's status code."); return }
//            guard let safeData = data else { print("From CommentsVC getComments: data is nil."); return }
//
//            if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
//                print("From CommentsVC downloadCommentsData: response is not 200.")
//                print(response ?? "No response at all.")
//            }
//            if httpResponse.statusCode == 204 {
//                print("From CommentsVC downloadCommentsData: no content.")
//                return
//            }
//
//            fetchComments(from: safeData)
//
//        }.resume()
//    }
//
//    func fetchComments(from answer: Data) {
//        do {
//            let decodedData = try JSONDecoder().decode([CommentModel].self, from: answer)
//            comments += decodedData
//            commentState += Array(repeating: CommentState(isLikePressed: false, isViewReplyPressed: false), count: decodedData.count)
//            commentImages += Array(repeating: UIImage(), count: decodedData.count)
//
//            page += 1
//            isPaginating = false
//
//            for comment in decodedData {
//                if comment.commentProjection.numberOfChildrenComments != 0 {
//                    commentsWithReplies[comment.commentProjection.id] = ReplyState(isShowing: false, page: 0)
//                }
//            }
//
//            DispatchQueue.main.async { [self] in
//                commentsTableView.tableHeaderView = nil
//                commentsTableView.tableFooterView = nil
//                commentsTableView.reloadData()
//            }
//
//        } catch {
//            print(error)
//        }
//    }
}

// MARK:- ViewRepliesDelegate
extension CommentsViewController: ViewRepliesDelegate {
    
    func viewReplies(_ cell: CommentTableViewCell) {
//        guard let indexPath = commentsTableView.indexPath(for: cell) else { print("From commentsVC viewReplies: indexPath is nil."); return }
//        if postID == nil { print("From commentsVC viewReplies: postID is nil."); return }
//        let comment = comments[indexPath.row]
//        getCommentReplies(postID: postID!, comment: comment)
    }
//
//    func getCommentReplies(postID: Int, comment: CommentModel) {
//        let page = commentsWithReplies[comment.commentProjection.id]!.page
//        let commentID = comment.commentProjection.id
//        let request = URLRequests.showCommentReplies(accessToken: tokenModel?.accessToken ?? "", postID: postID, commentID: commentID, page: page)
//        downloadCommentReplies(with: request, comment: comment)
//    }
//
//    func downloadCommentReplies(with request: URLRequest, comment: CommentModel) {
//        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
//
//            guard let httpResponse = response as? HTTPURLResponse else { print("From Comments downloadCommentsData: couldn't get response's status code."); return }
//            guard let safeData = data else { print("From CommentsVC getComments: data is nil."); return }
//
//            if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
//                print("From CommentsVC downloadCommentsData: problem getting comments data.")
//                print(response ?? "No response at all.")
//            }
//            if httpResponse.statusCode == 204 {
//                print("From CommentsVC downloadCommentsData: no content.")
//                return
//            }
//
//            fetchCommentReplies(from: safeData, comment: comment)
//
//        }.resume()
//    }
//
//    func fetchCommentReplies(from answer: Data, comment: CommentModel) {
//        do {
//            let decodedData = try JSONDecoder().decode([CommentModel].self, from: answer)
//
//            if let index = comments.firstIndex(where: { $0.commentProjection.id == comment.commentProjection.id }) {
//                comments.insert(contentsOf: decodedData, at: index + 1)
//            } else {
//                print("From CommentsVC fetchCommentReplies: index is nil.")
//                return
//            }
//
//            if !commentsWithReplies[comment.commentProjection.id]!.isShowing {
//                commentsWithReplies[comment.commentProjection.id]!.isShowing = true
//            }
//
//            commentsWithReplies[comment.commentProjection.id]!.page += 1
//            //            comments += decodedData
//            commentState = Array(repeating: CommentState(isLikePressed: false, isViewReplyPressed: false), count: comments.count)
//            commentImages = Array(repeating: UIImage(), count: comments.count)
//
//            isPaginating = false
//
//            DispatchQueue.main.async { [self] in
//                commentsTableView.tableHeaderView = nil
//                commentsTableView.tableFooterView = nil
//                commentsTableView.reloadData()
//            }
//
//        } catch {
//            print(error)
//        }
//    }
}

// MARK:- ReplyDelegate

extension CommentsViewController: ReplyDelegate {
    func replyButtonPressed(_ cell: CommentTableViewCell) {
        let indexPath = commentsTableView.indexPath(for: cell)!
        commentTextField.text = "@\(cell.commentModel!.commentProjection.author) "
        clearText = "@\(cell.commentModel!.commentProjection.author) "
        commentIdOfBeingReplied = comments[indexPath.row].commentProjection.id
        commentsTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        commentTextField.becomeFirstResponder()
    }
}

// MARK:- UsernameDelegate
extension CommentsViewController: UsernameDelegate {
    func goToUsername(_ cell: CommentTableViewCell) {
        let indexPath = commentsTableView.indexPath(for: cell)
        let comment = comments[indexPath!.row]
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        profileViewController.userID = comment.commentProjection.authorId
        
        profileViewController.navigationController?.isNavigationBarHidden = true
        
        let backItem = UIBarButtonItem()
        backItem.title = comment.commentProjection.author
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
}

// MARK:- UITableViewDelegate: Pagination
extension CommentsViewController: UITableViewDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        
        if position > commentsTableView.contentSize.height - 400 - scrollView.frame.size.height {
            if comments.count == numberOfComments { return }
            commentsTableView.tableFooterView = createSpinnerFooter()
//            getComments()
        }
        
        if position < -200 {
            page = 0
            commentsTableView.tableHeaderView = createSpinnerHeader()
//            getComments()
        }
    }
    
    func createSpinnerHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = headerView.center
        headerView.addSubview(spinner)
        spinner.startAnimating()
        
        return headerView
    }
    
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

// MARK:- LikeCommentDelegate
extension CommentsViewController: LikeCommentDelegate {
    func likeComment(_ cell: CommentTableViewCell) {
        let indexPath = commentsTableView.indexPath(for: cell)
        if commentState[indexPath!.row].isLikePressed {
//            unlike(commentID: comments[indexPath!.row].commentProjection.id, indexPath: indexPath!)
            commentState[indexPath!.row].isLikePressed = false
            cell.howManyLikesLabel.text = "\(comments[indexPath!.row].commentProjection.numberOfLikes - 1) Likes"
        } else {
//            like(commentID: comments[indexPath!.row].commentProjection.id, indexPath: indexPath!)
            commentState[indexPath!.row].isLikePressed = true
            cell.howManyLikesLabel.text = "\(comments[indexPath!.row].commentProjection.numberOfLikes + 1) Likes"
        }
    }
}

// Like/Unlike Post Process
extension CommentsViewController {
    
//    func unlike(commentID: Int, indexPath: IndexPath) {
//
//        let request = URLRequests.commentUnlike(accessToken: tokenModel?.accessToken ?? "", commentID: commentID)
//
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//
//            if let response = response {
//                print(response)
//            }
//
//            if let data = data {
//                do {
//                    let decodedData = try JSONDecoder().decode(CommentModel.self, from: data)
//                    self.comments[indexPath.row] = decodedData
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
//
//    func like(commentID: Int, indexPath: IndexPath) {
//
//        let request = URLRequests.commentLike(accessToken: tokenModel?.accessToken ?? "", commentID: commentID)
//
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//
//            if let response = response {
//                print(response)
//            }
//
//            if let data = data {
//                do {
//                    let decodedData = try JSONDecoder().decode(CommentModel.self, from: data)
//                    self.comments[indexPath.row] = decodedData
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
}
