//
//  ViewController.swift
//  PostFeed
//
//  Created by Yersage on 10.09.2021.
//

import UIKit

class FeedViewController: UIViewController, FeedViewDelegate {
    
    // MARK:- Initialization
    var posts: [PostModel] = []
    var postsState: [PostState] = []
        
    var presenter: FeedPresenterDelegate?

    private lazy var feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    // MARK:- Lifecycle functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FeedPresenter(view: self)
        layout()
        presenter?.downloadPosts(firstPage: true)
    }
    
    private func layout() {
        view.addSubview(feedTableView)
        feedTableView.dataSource = self
        feedTableView.frame = view.bounds
        feedTableView.allowsMultipleSelection = false
        feedTableView.separatorStyle = .none
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK:- FeedViewDelegate funcs
    func showError(error: String) {
        let alert = UIAlertController(title: "Title", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setPost(post: PostModel, index: Int) {
        print(posts[index])
        print(post)
        posts[index] = post
    }
    
    func set(newPosts: [PostModel]) {
        postsState += Array(repeating: PostState(isMorePressed: false, isSavePressed: false), count: newPosts.count)
        posts += newPosts
        feedTableView.reloadData()
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.feedTableView.reloadData()
        }
    }
    
    func removeSpinners() {
        DispatchQueue.main.async { [self] in
            if (feedTableView.tableHeaderView != nil) {
                feedTableView.tableHeaderView = nil
            }
            if feedTableView.tableFooterView != nil {
                feedTableView.tableFooterView = nil
            }
        }
    }
}

// MARK:- UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { print("FeedVC: Error dequeuing FeedTableViewCell."); return UITableViewCell() }
        
        cell.feedTableViewCellDelegate = self
        
        cell.postModel = posts[indexPath.row]
        cell.postState = postsState[indexPath.row]
                
        return cell
    }
}

// MARK:- UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > feedTableView.contentSize.height - 200 - scrollView.frame.size.height {
            feedTableView.tableFooterView = createSpinnerFooter()
            presenter?.downloadPosts(firstPage: false)
        }
        
        if position < -200 {
            feedTableView.tableHeaderView = createSpinnerHeader()
            presenter?.downloadPosts(firstPage: true)
        }
    }
}

// MARK:- Pagination Spinner views
extension FeedViewController {
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

// MARK:- FeedTableViewCellDelegate
extension FeedViewController: PostTableViewCellDelegate {
    func morePressed(_ cell: UITableViewCell) {
        let indexPath = feedTableView.indexPath(for: cell)
        postsState[indexPath!.row].isMorePressed = postsState[indexPath!.row].isMorePressed ? false : true
        feedTableView.reloadRows(at: [indexPath!], with: .middle)
    }
    
    // TODO: is it correct to make userID and username optional?
    func usernamePressed(_ cell: UITableViewCell) {
        guard let indexPath = feedTableView.indexPath(for: cell) else { return }
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.userID = posts[indexPath.row].post.user.id
        
        let backItem = UIBarButtonItem()
        backItem.title = posts[indexPath.row].post.user.username
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }

    // TODO: is it correct to make postID optional?
    func likePressed(_ cell: UITableViewCell, postID: Int?) {
        guard let indexPath = feedTableView.indexPath(for: cell) else { return }
        presenter?.like(like: posts[indexPath.row].postMetaData.isPostLikedByCurrentUser, postID: postID!, index: indexPath.row)
    }
    
    func unlikePressed(_ cell: UITableViewCell, postID: Int?) {
        guard let indexPath = feedTableView.indexPath(for: cell) else { return }
        presenter?.unlike(like: posts[indexPath.row].postMetaData.isPostLikedByCurrentUser, postID: postID!, index: indexPath.row)
        
    }
    
    // TODO: is it correct to make postID optional?
    func commentPressed(_ cell: UITableViewCell, postID: Int?) {
        let commentsVC = self.storyboard!.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentsVC.postID = postID
        DispatchQueue.main.async { [self] in
            self.navigationController!.pushViewController(commentsVC, animated: true)
        }
    }
    
    func savePressed(_ cell: UITableViewCell) {
        let indexPath = feedTableView.indexPath(for: cell)
        postsState[indexPath!.row].isSavePressed = postsState[indexPath!.row].isSavePressed ? false : true
        print("This functionality won't take place in the clone.")
    }
}
