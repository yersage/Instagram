//
//  WelcomeViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    //MARK:- IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var username: String?
    var password: String?
    
    private let presenter: WelcomePresenterDelegate
    
    init?(presenter: WelcomePresenterDelegate, coder: NSCoder) {
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
        presenter.login(username: username!, password: password!)
    }
    
    // MARK:- IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFeedVC", sender: self)
    }
    
    // MARK:- WelcomeViewDelegate funcs

}
