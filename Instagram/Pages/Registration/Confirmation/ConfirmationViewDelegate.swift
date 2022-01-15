//
//  ConfirmationViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol ConfirmationViewDelegate: AnyObject {
    func showWarning()
    func show(error: String)
    func showLabel()
    func hideLabel()
    func goToWelcomeVC()
}
