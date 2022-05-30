//
//  WelcomeViewController.swift
//  PostFeed
//
//  Created by Yersage on 26.09.2021.
//

import UIKit

final class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var presenter: WelcomePresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        presenter?.nextButtonPressed()
    }
}
