//
//  ProfilePostsViewController.swift
//  PostFeed
//
//  Created by Yersage on 20.09.2021.
//

import UIKit

class ProfilePostsViewController: UIViewController {
    
    var page: Int = 0
    var isPaginating: Bool = false
    
    var posts: [PostModel] = []
    var postsState: [PostState] = []
    
    private let postsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(postsTableView)
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.frame = view.bounds
    }
}

// MARK:- UITableViewDataSource
extension ProfilePostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { print("FeedVC: Error dequeuing FeedTableViewCell."); return UITableViewCell() }
        
        cell.feedTableViewCellDelegate = self
        
        cell.postModel = self.posts[indexPath.row]
        
        
        
        if postsState[indexPath.row].isMorePressed {
            cell.postCaptionLabel.numberOfLines = 0
            cell.captionMoreButton.isHidden = true
        }
        
        if postsState[indexPath.row].isSavePressed {
            cell.savePostImageView.tintColor = .red
        }
        
        if posts[indexPath.row].postMetaData.isPostLikedByCurrentUser {
            cell.likePostImageView.tintColor = .red
        }
        
        return cell
    }
}

// MARK:- UITableViewDelegate
extension ProfilePostsViewController: UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK:- Download Feed Posts
extension ProfilePostsViewController {
    
    //    func downloadPosts() {
    //
    //        if isPaginating { return }
    //        isPaginating = true
    //        let feedPostRequest = URLRequests.feedPosts(with: "", page: page)
    //
    //        URLSession.shared.dataTask(with: feedPostRequest) { [self] (data, response, error) in
    //
    //            guard let httpResponse = response as? HTTPURLResponse else { print("From FeedVC downloadFeedPosts: couldn't get response's status code."); return }
    //            guard let safeData = data else { print("From FeedVC downloadFeedPosts: no feed posts."); return }
    //
    //            if httpResponse.statusCode != 200 {
    //                print("Problem getting feed posts.")
    //                print(response ?? "No response at all.")
    //                return
    //            }
    //
    //            self.fetchFeedPosts(from: safeData)
    //
    //            DispatchQueue.main.async { [self] in
    //                isPaginating = false
    //                if (postsTableView.tableHeaderView != nil) {
    //                    postsTableView.tableHeaderView = nil
    //                }
    //                if postsTableView.tableFooterView != nil {
    //                    postsTableView.tableFooterView = nil
    //                }
    //            }
    //
    //        }.resume()
    //    }
    //
    //    func fetchFeedPosts(from answer: Data) {
    //        do {
    //            let decodedData = try JSONDecoder().decode([PostModel].self, from: answer)
    //
    //            page += 1
    //            posts += decodedData
    //            postsState = Array(repeating: PostState(isMorePressed: false, isLikePressed: false, isSavePressed: false), count: posts.count)
    //
    //            DispatchQueue.main.async { [self] in
    //                postsTableView.reloadData()
    //            }
    //        } catch {
    //            print(error)
    //        }
    //    }
}

// MARK:- Pagination
extension ProfilePostsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > postsTableView.contentSize.height - 200 - scrollView.frame.size.height {
            postsTableView.tableFooterView = createSpinnerFooter()
            //            downloadPosts()
        }
        
        if position < -200 {
            page = 0
            postsTableView.tableHeaderView = createSpinnerHeader()
            //            downloadPosts()
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

extension ProfilePostsViewController: PostTableViewCellDelegate {
    func morePressed(_ cell: UITableViewCell) {
        let indexPath = postsTableView.indexPath(for: cell)
        postsState[indexPath!.row].isMorePressed = postsState[indexPath!.row].isMorePressed ? false : true
        postsTableView.reloadRows(at: [indexPath!], with: .middle)
    }
    
    func savePressed(_ cell: UITableViewCell) {
        let indexPath = postsTableView.indexPath(for: cell)
        postsState[indexPath!.row].isSavePressed = postsState[indexPath!.row].isSavePressed ? false : true
    }
    
    func usernamePressed(_ cell: UITableViewCell) {
        guard let indexPath = postsTableView.indexPath(for: cell) else { return }
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.userID = posts[indexPath.row].post.user.id
        profileViewController.navigationController?.isNavigationBarHidden = true
        
        let backItem = UIBarButtonItem()
        backItem.title = posts[indexPath.row].post.user.username
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
    
    func commentPressed(_ cell: UITableViewCell, postID: Int?) {
        let commentsVC = self.storyboard!.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentsVC.postID = postID
        DispatchQueue.main.async { [self] in
            self.navigationController!.pushViewController(commentsVC, animated: true)
        }
    }
    
    func likePressed(_ cell: UITableViewCell, postID: Int?) {
//        let indexPath = postsTableView.indexPath(for: cell)
    }
    
    func unlikePressed(_ cell: UITableViewCell, postID: Int?) {
//        let indexPath = postsTableView.indexPath(for: cell)

    }
}

// Like/Unlike Post Process
extension ProfilePostsViewController {
    
    //    func unlike(postID: Int, indexPath: IndexPath) {
    //
    //        let request = URLRequests.postUnlike(accessToken: "", postID: postID)
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
    //                    let decodedData = try JSONDecoder().decode(PostModel.self, from: data)
    //                    self.posts[indexPath.row] = decodedData
    //                } catch {
    //                    print(error)
    //                }
    //            }
    //        }.resume()
    //    }
    //
    //    func like(postID: Int, indexPath: IndexPath) {
    //
    //        let request = URLRequests.postLike(accessToken: "", postID: postID)
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
    //                    let decodedData = try JSONDecoder().decode(PostModel.self, from: data)
    //                    self.posts[indexPath.row] = decodedData
    //                } catch {
    //                    print(error)
    //                }
    //            }
    //        }.resume()
    //    }
}

