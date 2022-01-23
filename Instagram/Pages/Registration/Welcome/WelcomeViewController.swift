//
//  WelcomeViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var username: String?
    var password: String?
    
    var presenter: WelcomePresenterDelegate?
    
    // MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.login(username: username!, password: password!)
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFeedVC", sender: self)
    }
    
    // MARK:- WelcomeViewDelegate funcs
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToFeedVC() {
        //router.route(to: Route.login.rawValue, from: self, parameters: nil)
    }
}
