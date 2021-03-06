//
//  SelfProfileViewController.swift
//  PostFeed
//
//  Created by Yersage on 21.12.2021.
//

import UIKit

final class SelfProfileViewController: UIViewController, SelfProfileViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var profileImageView: CachedImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    // MARK:- Initialization
    var presenter: SelfProfilePresenterDelegate?
    
    var posts: [PostModel] = []
    var postState: [PostState] = []
    
    var profileModel: ProfileModel?
//    var userID: Int = UserDefaultsManager.shared.getUserID()

    // MARK:- Lifecycle functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
//        presenter?.getProfileData(userID: userID)
//        presenter?.getPosts(firstPage: true, userID: "\(userID)")
//        profileImageView.loadImagesFromUserID(userID: userID)
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
    
    // MARK:- SelfProfileViewDelegate funcs
    func set(profileModel: ProfileModel) {
        self.profileModel = profileModel
    }
    
    func setupProfileData() {
        followersLabel.text = "\(profileModel?.user.numberOfFollowers ?? 0) Followers"
        followingLabel.text = "\(profileModel?.user.numberOfFollowings ?? 0) Following"
        postsLabel.text = "\(profileModel?.user.numberOfPosts ?? 0) Posts"
        
        usernameLabel.text = profileModel?.user.username
        nameLabel.text = profileModel?.user.name
        bioLabel.text = profileModel?.user.bio
        websiteLabel.text = profileModel?.user.website
    }
    
    func set(posts: [PostModel]) {
        self.posts += posts
    }
    
    func refresh() {
        postsCollectionView.reloadData()
    }
    
    func enableEditProfileButton() {
        DispatchQueue.main.async {
            self.editProfileButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditProfileVC" {
            guard let editProfileVC = segue.destination as? EditProfileViewController else { return }
            editProfileVC.username = profileModel?.user.username
            editProfileVC.name = profileModel?.user.name
            editProfileVC.bio = profileModel?.user.bio
            editProfileVC.website = profileModel?.user.website
        }
    }
}

// MARK:- IBActions
extension SelfProfileViewController {
    @IBAction func postsButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func followersButtonPressed(_ sender: UIButton) {
        let followersVC = self.storyboard!.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
//        followersVC.userID = userID
        self.navigationController!.pushViewController(followersVC, animated: true)
    }
    
    @IBAction func followingButtonPressed(_ sender: UIButton) {
        let followingVC = self.storyboard!.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
//        followingVC.userID = userID
        self.navigationController!.pushViewController(followingVC, animated: true)
    }
    
    @IBAction func editProfilePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToEditProfileVC", sender: self)
    }
}

// MARK:- UICollectionViewDataSource
extension SelfProfileViewController: UICollectionViewDataSource {
    
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
extension SelfProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePostsViewController") as! ProfilePostsViewController
        postVC.posts = posts
        self.navigationController!.pushViewController(postVC, animated: true)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension SelfProfileViewController: UICollectionViewDelegateFlowLayout {
    
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
