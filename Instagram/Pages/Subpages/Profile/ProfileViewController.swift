//
//  ProfileViewController.swift
//  PostFeed
//
//  Created by Yersage on 14.09.2021.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var profileImageView: CachedImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    // MARK:- Initialization
    private var presenter: ProfilePresenterDelegate?
    
    var posts: [PostModel] = []
    var postState: [PostState] = []
    
    var profileModel: ProfileModel?
    var userID: Int?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter = ProfilePresenter(view: self)
        guard let userID = userID else { return }
        presenter?.getProfileData(userID: userID)
        presenter?.getPosts(firstPage: true, userID: "\(userID)")
        profileImageView.loadImagesFromUserID(userID: userID)
    }
    
    func layout() {
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        postsCollectionView.register(ProfilePostsCollectionViewCell.nib(), forCellWithReuseIdentifier: ProfilePostsCollectionViewCell.identifier)
        postsCollectionView.register(LoaderCell.self, forCellWithReuseIdentifier: LoaderCell.identifier)
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- IBActions
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        //        postsCollectionView.reloadData()
    }
    
    @IBAction func followButtonPressed(_ sender: UIButton) {
        if followButton.titleLabel?.text == "Follow" {
            presenter?.follow(userID: userID)
            followButton.setTitleColor(.black, for: .normal)
            followButton.setTitle("Following", for: .normal)
            followButton.backgroundColor = .none
        } else {
            presenter?.unfollow(userID: userID)
            followButton.setTitleColor(.white, for: .normal)
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .blue
        }
    }
    
    @IBAction func followersButtonPressed(_ sender: UIButton) {
        let followersVC = self.storyboard!.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
        followersVC.userID = userID
        DispatchQueue.main.async { [self] in
            self.navigationController!.pushViewController(followersVC, animated: true)
        }
    }
    
    @IBAction func followingButtonPressed(_ sender: UIButton) {
        let followingVC = self.storyboard!.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
        followingVC.userID = userID
        DispatchQueue.main.async { [self] in
            self.navigationController!.pushViewController(followingVC, animated: true)
        }
    }
    
    // MARK:- ProfileViewDelegate funcs
    func set(profileModel: ProfileModel) {
        self.profileModel = profileModel
    }
    
    func setupProfileData() {
        DispatchQueue.main.async { [self] in
            
            followersLabel.text = "\(profileModel?.user.numberOfFollowers ?? 0) Followers"
            followingLabel.text = "\(profileModel?.user.numberOfFollowings ?? 0) Following"
            postsLabel.text = "\(profileModel?.user.numberOfPosts ?? 0) Posts"
            
            usernameLabel.text = profileModel?.user.username
            nameLabel.text = profileModel?.user.name
            bioLabel.text = profileModel?.user.bio
            websiteLabel.text = profileModel?.user.website
            
            followButton.layer.cornerRadius = 10
            followButton.layer.borderWidth = 0.5
            
            if profileModel?.userMetaData.isFollowedByCurrentUser == true {
                followButton.setTitleColor(.black, for: .normal)
                followButton.setTitle("Following", for: .normal)
                followButton.backgroundColor = .none
            }
        }
    }
    
    func set(posts: [PostModel]) {
        self.posts += posts
    }
    
    func show(error: String) {
        print(error)
    }
    
    func reload() {
        postsCollectionView.reloadData()
    }
}

// MARK:- UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if profileModel?.user.numberOfPosts == self.posts.count {
            return self.posts.count
        } else {
            return (self.posts.count > 0) ? (self.posts.count + 1) : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row <= posts.count - 1 {
            guard let cell = postsCollectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostsCollectionViewCell.identifier, for: indexPath) as? ProfilePostsCollectionViewCell else { print("From ProfileVC cellForItemAt: couldn't dequeue cell."); return UICollectionViewCell() }
            cell.configure(with: posts[indexPath.row].post.id)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoaderCell.identifier, for: indexPath) as? LoaderCell else { print("Couldn't dequeue indicatorCell."); return UICollectionViewCell() }
            cell.loader.startAnimating()
            return cell
        }
    }
}

// MARK:- UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        let postVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePostsViewController") as! ProfilePostsViewController
        postVC.posts = posts
        self.navigationController!.pushViewController(postVC, animated: true)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let size = collectionView.frame.size
        let cellHeight =  (indexPath.row == posts.count) ? 40 : 130 // potential bug. Should I have an access to isPaginating?
        return CGSize(width: 130, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == posts.count ) {
//            presenter?.getPosts(firstPage: false, userID: userID)
        }
    }
}
