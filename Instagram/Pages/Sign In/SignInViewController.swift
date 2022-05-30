//
//  SignInViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class SignInViewController: UIViewController, SignInViewDelegate {
    
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: SignInPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        presenter?.loginButtonPressed(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        presenter?.signUpButtonPressed()
    }
}
