//
//  UIVIewController+ErrorHandler.swift
//  Instagram
//
//  Created by Yersage on 17.04.2022.
//

import Foundation
import UIKit

protocol ErrorHandler {
    func show(error: String)
}

extension UIViewController: ErrorHandler {
    @objc func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
