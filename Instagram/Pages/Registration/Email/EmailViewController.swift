//
//  EmailViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class EmailViewController: UIViewController, EmailViewDelegate {

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
        
    var presenter: EmailPresenterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.nextButtonPressed(email: emailTextField.text!)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        presenter?.signInButtonPressed()
    }
    
    func updateLabel(isHidden: Bool, text: String?) {
        validationLabel.text = text
        validationLabel.isHidden = isHidden
    }
}
