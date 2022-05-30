//
//  BasicCoordinator.swift
//  Instagram
//
//  Created by Yersage on 18.04.2022.
//

import Foundation
import UIKit

class BasicCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
        
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func profile(userProjection: UserProjection) {
        let vc = ProfileViewController.instantiate()
        let presenter = ProfilePresenter()
        presenter.view = vc
//        presenter.coordinator = self
//        presenter.userProjection = userProjection
        
//        let backItem = UIBarButtonItem()
//        backItem.title = posts[indexPath.row].post.user.username
//        navigationItem.backBarButtonItem = backItem
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func followers() {
        
    }
    
    func following() {
        
    }
    
    func posts() {
        
    }
    
    func comments(postID: Int) {
//        let vc = CommentsViewController()
//        let presenter = ...
//
//          navigationController.push...
    }
}
