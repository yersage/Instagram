//
//  PasswordViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class PasswordViewController: UIViewController, PasswordViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email: String?
    var username: String?
    var presenter: PasswordPresenterDelegate?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PasswordPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.isPasswordAcceptable(password: passwordTextField.text!)
    }
    
    // MARK:- PasswordViewDelegate funcs
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLabel(text: String) {
        validationLabel.isHidden = false
        validationLabel.text = text
    }
    
    func hideLabel() {
        validationLabel.isHidden = true
    }
    
    func goToWelcomeVC() {
        performSegue(withIdentifier: "goToConfirmationVC", sender: self)
    }
}

// MARK:- Prepare for segue
extension PasswordViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConfirmationVC" {
            guard let confirmationVC = segue.destination as? ConfirmationViewController else { return }
            confirmationVC.email = email
            confirmationVC.username = username
            confirmationVC.password = passwordTextField.text!            
        }
    }
}
