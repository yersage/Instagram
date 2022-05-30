//
//  UsernameViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class UsernameViewController: UIViewController, UsernameViewDelegate {

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var presenter: UsernamePresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.nextButtonPressed(username: usernameTextField.text!)
    }
    
    func updateLabel(isHidden: Bool, text: String?) {
        validationLabel.text = text
        validationLabel.isHidden = isHidden
    }
}
