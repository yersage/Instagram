//
//  ConfirmationViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol ConfirmationViewDelegate: AnyObject {
    func setupLabel(email: String)
    func showWarning()
    func show(error: String)
    func updateLabel(isHidden: Bool, text: String?)
}
