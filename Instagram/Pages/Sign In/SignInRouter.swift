//
//  SignInRouter.swift
//  Instagram
//
//  Created by Yersage on 26.01.2022.
//

import UIKit

enum SignInRouterPath {
    case signUp
    case feed
}

class SignInRouter {
    weak var viewController: SignInViewController!
    
    func navigate(to path: SignInRouterPath) {
        switch path {
        case .signUp:
            goToEmailVC()
        case .feed:
            goToFeedVC()
        }
    }
    
    private func goToEmailVC() {
        guard let emailVC = viewController.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as? EmailViewController else { return }
        let presenter = EmailPresenter()
        presenter.view = emailVC
        emailVC.presenter = EmailPresenter()
        
        viewController.navigationController?.pushViewController(emailVC, animated: true)
    }
    
    private func goToFeedVC() {
        let storyboard = viewController?.storyboard
        
        let tabBarVC = UITabBarController()
        
        guard let feedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController else { return }
        let feedPresenter = FeedPresenter()
        feedPresenter.view = feedVC
        feedVC.presenter = feedPresenter
        
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        let searchPresenter = SearchPresenter()
        searchPresenter.view = searchVC
        searchVC.presenter = searchPresenter
        
        guard let createPostVC = storyboard?.instantiateViewController(withIdentifier: "CreatePostViewController") as? CreatePostViewController else { return }
        let createPostPresenter = CreatePostPresenter()
        createPostPresenter.view = createPostVC
        createPostVC.presenter = createPostPresenter
        
        guard let notificationsVC = storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController") as? NotificationsViewController else { return }
        
        guard let selfProfileVC = storyboard?.instantiateViewController(withIdentifier: "SelfProfileViewController") as? SelfProfileViewController else { return }
        let selfProfilePresenter = SelfProfilePresenter()
        selfProfilePresenter.view = selfProfileVC
        selfProfileVC.presenter = selfProfilePresenter
        
        feedVC.title = "Feed"
        searchVC.title = "Search"
        createPostVC.title = "Create Post"
        notificationsVC.title = "Notifications"
        selfProfileVC.title = "Profile"
            
        tabBarVC.setViewControllers([
            UINavigationController(rootViewController: feedVC),
            UINavigationController(rootViewController: searchVC),
            UINavigationController(rootViewController: createPostVC),
            UINavigationController(rootViewController: notificationsVC),
            UINavigationController(rootViewController: selfProfileVC)],
                                    animated: false)
        
        tabBarVC.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(tabBarVC, animated: false)
    }
}
