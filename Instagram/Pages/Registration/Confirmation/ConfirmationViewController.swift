//
//  ConfirmationViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class ConfirmationViewController: UIViewController, ConfirmationViewDelegate {
    // MARK:- IBOutlets
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    var email: String?
    var username: String?
    var password: String?
    
    private let presenter: ConfirmationPresenterDelegate
    
    init?(presenter: ConfirmationPresenterDelegate, coder: NSCoder) {
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
        captionLabel.text = "Enter the confirmation code we sent to \(email!)."
        presenter.signup(email: email!, password: password!, username: username!)
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter.verify(email: email!, verificationCode: verificationCodeTextField.text!)
    }
    
    // MARK:- ConfirmationViewDelegate funcs
    func showWarning() {
        let message = "Given parameters are reserved for one hour. If confirmation code is not provided, parameters will be removed from server."
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLabel() {
        DispatchQueue.main.async {
            self.validationLabel.isHidden = false
        }
    }
    
    func hideLabel() {
        DispatchQueue.main.async {
            self.validationLabel.isHidden = true
        }
    }
    
    func goToWelcomeVC() {
        performSegue(withIdentifier: "goToWelcomeVC", sender: self)
    }
}

// MARK:- Prepare for segue
extension ConfirmationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWelcomeVC" {
            guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
            welcomeVC.username = username
            welcomeVC.password = password
        }
    }
}
