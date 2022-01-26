//
//  SignInViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class SignInViewController: UIViewController, SignInViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private var presenter: SignInPresenter?
    // как отдать навКонтроллер пресентеру?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        presenter = SignInPresenter()
        presenter?.view = self

        super.viewDidLoad()
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
        guard let emailVC = storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as? EmailViewController else { return }
        let presenter = EmailPresenter()
        presenter.view = emailVC
        emailVC.presenter = EmailPresenter()
        
        let backItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(emailVC, animated: true)
    }
    
    // MARK:- SignInViewDelegate funcs
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToFeedVC() {
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
        navigationController?.pushViewController(tabBarVC, animated: false)
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
