//
//  UIViewController+Storyboarded.swift
//  Instagram
//
//  Created by Yersage on 16.04.2022.
//

import UIKit

extension UIViewController: Storyboarded { }

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
