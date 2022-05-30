//
//  TabBarCoordinator.swift
//  Instagram
//
//  Created by Yersage on 16.04.2022.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarVC = UITabBarController()
        
        let feedVC = FeedViewController.instantiate()
        let feedPresenter = FeedPresenter()
        let tableView = FeedTableView()
        feedPresenter.view = feedVC
        
        feedVC.presenter = feedPresenter
        
        let searchVC = SearchViewController.instantiate()
        let searchPresenter = SearchPresenter()
        searchPresenter.view = searchVC
        searchVC.presenter = searchPresenter
        
        let createPostVC = CreatePostViewController.instantiate()
        let createPostPresenter = CreatePostPresenter()
        createPostPresenter.view = createPostVC
        createPostVC.presenter = createPostPresenter
        
        let notificationsVC = NotificationsViewController.instantiate()
        
        let selfProfileVC = SelfProfileViewController.instantiate()
        let selfProfilePresenter = SelfProfilePresenter()
        selfProfilePresenter.view = selfProfileVC
        selfProfileVC.presenter = selfProfilePresenter
            
        tabBarVC.setViewControllers([
            UINavigationController(rootViewController: feedVC),
            UINavigationController(rootViewController: searchVC),
            UINavigationController(rootViewController: createPostVC),
            UINavigationController(rootViewController: notificationsVC),
            UINavigationController(rootViewController: selfProfileVC)],
                                    animated: false)
        
        tabBarVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(tabBarVC, animated: false)
    }
}
