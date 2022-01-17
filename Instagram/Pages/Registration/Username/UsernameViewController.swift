//
//  UsernameViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class UsernameViewController: UIViewController, UsernameViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var email: String?
    private let presenter: UsernamePresenterDelegate
    
    init?(presenter: UsernamePresenterDelegate, coder: NSCoder) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(product:coder:)")
    required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter.isUsernameAcceptable(username: usernameTextField.text!)
    }
    
    // MARK:- UsernameViewDelegate funcs
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
