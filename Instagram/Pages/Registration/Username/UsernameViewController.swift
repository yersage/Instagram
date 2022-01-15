//
//  UsernameViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class UsernameViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var email: String?
    var presenter: UsernamePresenterDelegate?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UsernamePresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.isUsernameAcceptable(username: usernameTextField.text!)
    }
}

// MARK:- UsernameViewDelegate
extension UsernameViewController: UsernameViewDelegate {
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
    
    func goToPasswordVC() {
        performSegue(withIdentifier: "goToPasswordVC", sender: self)
    }
}

//MARK:- Prepare for segue
extension UsernameViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPasswordVC" {
            guard let passwordVC = segue.destination as? PasswordViewController else { return }
            passwordVC.email = email
            passwordVC.username = usernameTextField.text!            
        }
    }
}
