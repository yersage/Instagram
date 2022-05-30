//
//  AuthCoordinator.swift
//  Instagram
//
//  Created by Yersage on 16.04.2022.
//

import Foundation
import UIKit

class SignUpCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = EmailViewController.instantiate()
        let presenter = EmailPresenter()
        presenter.view = vc
        presenter.coordinator = self
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
    }
    
    func username(authModel: AuthModel) {
        let vc = UsernameViewController.instantiate()
        let presenter = UsernamePresenter(authModel: authModel)
        presenter.view = vc
        presenter.coordinator = self
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
    }
    
    func password(authModel: AuthModel) {
        let vc = PasswordViewController.instantiate()
        let presenter = PasswordPresenter(authModel: authModel)
        presenter.view = vc
        presenter.coordinator = self
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
    }
    
    func confirmation(authModel: AuthModel) {
        let vc = ConfirmationViewController.instantiate()
        let presenter = ConfirmationPresenter(authModel: authModel)
        presenter.view = vc
        presenter.coordinator = self
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
    }
    
    func welcome(authModel: AuthModel) {
        let vc = WelcomeViewController.instantiate()
        let presenter = WelcomePresenter(authModel: authModel)
        presenter.view = vc
        presenter.coordinator = self
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        parentCoordinator?.signIn()
        parentCoordinator?.childDidFinish(self)
    }
}
