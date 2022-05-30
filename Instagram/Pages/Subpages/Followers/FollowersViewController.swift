//
//  FollowersViewController.swift
//  PostFeed
//
//  Created by Yersage on 15.09.2021.
//

import UIKit

final class FollowersViewController: UIViewController, FollowersViewDelegate {
    // MARK:-  Initialization
    var followers: [ProfileModel] = []
    var followersState: [FollowersState] = []
    
    var userID: Int?
    var presenter: FollowersPresenterDelegate?
    
    private let followersTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter?.getFollowers(firstPage: true, userID: userID)
    }
    
    private func layout() {
        view.addSubview(followersTableView)
        followersTableView.dataSource = self
        followersTableView.frame = view.bounds
        followersTableView.separatorStyle = .none
        followersTableView.register(FollowersTableViewCell.self, forCellReuseIdentifier: FollowersTableViewCell.identifier)
        followersTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- FollowersViewDelegate funcs
    func set(followers: [ProfileModel]) {
        for follower in followers {
            followersState.append(FollowersState(isFollowing: follower.userMetaData.isFollowedByCurrentUser, isRemoved: false))
        }
        self.followers += followers
    }
    
    func removeSpinners() {
        followersTableView.tableFooterView = nil
        followersTableView.tableHeaderView = nil
    }
    
    func refresh() {
        followersTableView.reloadData()
    }
}

// MARK:- UITableViewDataSource
extension FollowersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowersTableViewCell.identifier, for: indexPath) as? FollowersTableViewCell else { print("From FollowersVC: error dequeuing cell."); return UITableViewCell() }
        
        cell.delegate = self
        cell.set(followersState[indexPath.row])
        cell.set(followers[indexPath.row])
        
        return cell
    }
}

// MARK:- Pagination
extension FollowersViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > followersTableView.contentSize.height - 200 - scrollView.frame.size.height {
            followersTableView.tableFooterView = createSpinnerFooter()
            presenter?.getFollowers(firstPage: false, userID: userID)
        }
        
        if position < -200 {
            followersTableView.tableHeaderView = createSpinnerHeader()
            presenter?.getFollowers(firstPage: true, userID: userID)
        }
    }
    
    private func createSpinnerHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = headerView.center
        headerView.addSubview(spinner)
        spinner.startAnimating()
        
        return headerView
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension FollowersViewController: FollowersTableViewCellDelegate {
    
    func followPressed(_ cell: UITableViewCell) {
        presenter?.follow()
    }
    
    func removePressed(_ cell: UITableViewCell, postID: Int?) {
        presenter?.remove()
    }
    
    func usernamePressed(_ cell: UITableViewCell, userID: String?, username: String?) {
        
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        profileViewController.userID = userID!
        profileViewController.navigationController?.isNavigationBarHidden = true
        
        let backItem = UIBarButtonItem()
        backItem.title = username
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
}
