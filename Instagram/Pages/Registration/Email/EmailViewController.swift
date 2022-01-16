//
//  EmailViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class EmailViewController: UIViewController, EmailViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    var presenter: EmailPresenterDelegate?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EmailPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.isEmailAcceptable(email: emailTextField.text!)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- EmailViewDelegate funcs
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLabel(text: String) {
        validationLabel.text = text
        validationLabel.isHidden = false
    }
    
    func hideLabel() {
        validationLabel.isHidden = true
    }
    
    func goToUsernameVC() {
        performSegue(withIdentifier: "goToUsernameVC", sender: self)
    }
}

// MARK:- Prepare for segue
extension EmailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUsernameVC" {
            guard let usernameVC = segue.destination as? UsernameViewController else { return }
            usernameVC.email = emailTextField.text!
        }
    }
}
