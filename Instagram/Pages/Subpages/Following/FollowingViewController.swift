//
//  FollowingViewController.swift
//  PostFeed
//
//  Created by Yersage on 15.09.2021.
//

import UIKit

final class FollowingViewController: UIViewController, FollowingViewDelegate {
    // MARK:- Initialization
    private var followings: [ProfileModel] = []
    private var followingState: [FollowingState] = []
    
    var userID: Int?
    
    private let presenter: FollowingPresenterDelegate
    
    init?(presenter: FollowingPresenterDelegate, coder: NSCoder) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(product:coder:)")
    required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }
    
    private let followingTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
        
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getFollowings(firstPage: true)
        layout()
        view.addSubview(followingTableView)
    }
    
    private func layout() {
        followingTableView.dataSource = self
        followingTableView.register(FollowingTableViewCell.self, forCellReuseIdentifier: FollowingTableViewCell.identifier)
        followingTableView.frame = view.bounds
        followingTableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- FollowingViewDelegate funcs
    func set(followings: [ProfileModel]) {
        for following in followings {
            followingState.append(FollowingState(isFollowing: following.userMetaData.isFollowedByCurrentUser))
        }
        self.followings += followings
    }
    
    func removeSpinners() {
        followingTableView.tableHeaderView = nil
        followingTableView.tableFooterView = nil
    }
    
    func refresh() {
        followingTableView.reloadData()
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Title", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK:- UITableViewDataSource
extension FollowingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.identifier, for: indexPath) as? FollowingTableViewCell else { print("From FollowingVC: error dequeuing cell."); return UITableViewCell() }
        
        if followings.count == 0 {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        cell.isFollowing = followings[indexPath.row].userMetaData.isFollowedByCurrentUser
        cell.followingModel = followings[indexPath.row]
        
        return cell
    }
}

extension FollowingViewController: FollowingTableViewCellDelegate {
    func usernamePressed(_ cell: UITableViewCell, userID: String?, username: String?) {
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        profileViewController.userID = userID!
        
        profileViewController.navigationController?.isNavigationBarHidden = true
        
        let backItem = UIBarButtonItem()
        backItem.title = username
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
    
    func follow() {
        presenter.follow()
    }
    
    func unfollow() {
        presenter.unfollow()
    }
    
    
}

// MARK:- UITableViewDelegate: Pagination
extension FollowingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > followingTableView.contentSize.height - 400 - scrollView.frame.size.height {
            followingTableView.tableFooterView = createSpinnerFooter()
            presenter.getFollowings(firstPage: false)
        }
        
        if position < -200 {
            followingTableView.tableHeaderView = createSpinnerHeader()
            presenter.getFollowings(firstPage: true)
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
