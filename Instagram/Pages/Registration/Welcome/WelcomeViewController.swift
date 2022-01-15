//
//  WelcomeViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var username: String?
    var password: String?
    var presenter: WelcomePresenterDelegate?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WelcomePresenter(view: self)
        presenter!.login(username: username!, password: password!)
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFeedVC", sender: self)
    }
}

// MARK:- WelcomeViewDelegate
extension WelcomeViewController: WelcomeViewDelegate {
    
}
