//
//  ConfirmationViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class ConfirmationViewController: UIViewController, ConfirmationViewDelegate {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    var presenter: ConfirmationPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.nextButtonPressed(verificationCode: verificationCodeTextField.text!)
    }
    
    func setupLabel(email: String) {
        captionLabel.text = "Enter the confirmation code we sent to \(email)."
    }
    
    func showWarning() {
        let alert = UIAlertController(title: "Warning", message: K.confirmationCodeWarning, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateLabel(isHidden: Bool, text: String?) {
        validationLabel.text = text
        validationLabel.isHidden = isHidden
    }
}
