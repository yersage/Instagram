//
//  SignInRouter.swift
//  Instagram
//
//  Created by Yersage on 17.01.2022.
//

import UIKit

final class SignInRouter: RouterDelegate {
    let presenter: SignInPresenterDelegate
    let navigationController: UINavigationController
    
    init(presenter: SignInPresenterDelegate, navigationController: UINavigationController) {
        self.presenter = presenter
        self.navigationController = navigationController
    }
    
    func route(to routeID: String, from context: UIViewController, parameters: Any?) {
        guard let route = SignInViewController.Route(rawValue: routeID) else { return }
        switch route {
        case .login:
            let presenter = FeedPresenter()
            guard let vc = context.storyboard?.instantiateViewController(identifier: "FeedViewController", creator: { coder in
                FeedViewController(presenter: presenter, coder: coder)
            }) else { return }
            presenter.view = vc
            context.navigationController?.pushViewController(vc, animated: true)
        case .signUp:
            let presenter = EmailPresenter()
            guard let vc = context.storyboard?.instantiateViewController(identifier: "EmailViewController", creator: { coder in
                EmailViewController(presenter: presenter, coder: coder)
            }) else { return }
            presenter.view = vc
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
