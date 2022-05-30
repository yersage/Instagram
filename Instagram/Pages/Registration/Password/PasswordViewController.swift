//
//  PasswordViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class PasswordViewController: UIViewController, PasswordViewDelegate {

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: PasswordPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.nextButtonPressed(password: passwordTextField.text!)
    }
    
    func updateLabel(isHidden: Bool, text: String?) {
        validationLabel.text = text
        validationLabel.isHidden = isHidden
    }
}
