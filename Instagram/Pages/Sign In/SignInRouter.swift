//
//  SignInRouter.swift
//  Instagram
//
//  Created by Yersage on 17.01.2022.
//

import UIKit

class SignInRouter: Router {
    func route(to routeID: String, from context: UIViewController, parameters: Any?) {
        guard let route = SignInViewController.Route(rawValue: routeID) else { return }
        switch route {
        case .login:
            let presenter = FeedPresenter(view: self)
            let vc = FeedViewController()
            
        case .signUp:
            // Push sign-up-screen:
            let vc = SignUpViewController()
            let vm = SignUpViewModel()
            vc.viewModel = vm
            vc.router = SignUpRouter(viewModel: vm)
            context.navigationController.push(vc, animated: true)
        case . forgotPasswordScreen:
        // Push forgot-password-screen.
        }
    }
}
