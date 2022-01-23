//
//  ChangeDataViewController.swift
//  PostFeed
//
//  Created by Yersage on 07.10.2021.
//

import UIKit

final class ChangePropertyViewController: UIViewController, ChangePropertyViewDelegate {
    
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var propertyTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    var presenter: ChangePropertyPresenterDelegate?
    
    var property: String?
    var value: String?
    var completionHandler: ((String) -> Void)?
    private var isUsernameValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyTextField.delegate = self
        if let property = property {
            propertyLabel.text = property
            propertyTextField.placeholder = value
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        validationLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func doneButtonPressed() {
        if isUsernameValid {
            completionHandler?(propertyTextField.text!)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK:- ChangePropertyViewDelegate funcs
    func hideValidationLabel() {
        isUsernameValid = true
        DispatchQueue.main.async {
            self.validationLabel?.isHidden = true
        }
    }
    
    func showValidationLabel(_ text: String) {
        isUsernameValid = false
        DispatchQueue.main.async {
            self.validationLabel?.text = text
            self.validationLabel?.isHidden = false
        }
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK:- UITextFieldDelegate
extension ChangePropertyViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if property == "Username" && textField.text! != "" {
            presenter?.checkUsername(textField.text!)
        }
        if property != "Username" {
            isUsernameValid = true
        } else if textField.text! == "" {
            isUsernameValid = false
            DispatchQueue.main.async {
                self.validationLabel.isHidden = true
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if property == "Username" && textField.text! != "" {
            presenter?.checkUsername(textField.text!)
        }
        if property != "Username" {
            isUsernameValid = true
        } else if textField.text! == "" {
            isUsernameValid = false
            DispatchQueue.main.async {
                self.validationLabel.isHidden = true
            }
        }
    }
}
