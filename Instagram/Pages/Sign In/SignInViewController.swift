//
//  SignInViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: SignInPresenterDelegate?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignInPresenter(view: self)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        if usernameTextField.text! != "" && passwordTextField.text! != "" {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:- @IBActions
    @IBAction func passwordVisibilityButtonPressed(_ sender: UIButton) {
        if passwordTextField.isSecureTextEntry == true {
            passwordTextField.isSecureTextEntry = false
            passwordVisibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordVisibilityButton.tintColor = .blue
        } else {
            passwordTextField.isSecureTextEntry = true
            passwordVisibilityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordVisibilityButton.tintColor = .gray
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        presenter?.login(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToEmailVC", sender: self)
    }
}

// MARK:- UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            presenter?.login(username: usernameTextField.text!, password: passwordTextField.text!)
        }

        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        loginButton.alpha = 0.5
        loginButton.isEnabled = false
            
        if usernameTextField.text == "" {
            usernameTextField.placeholder = "Username"
        } else if passwordTextField.text == "" {
            passwordTextField.placeholder = "Password"
        } else {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
            return
        }
    }
}

// MARK:- SignInViewDelegate
extension SignInViewController: SignInViewDelegate {
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToFeedVC() {
        performSegue(withIdentifier: "goToFeedVC", sender: self)
    }
}
