//
//  UsernameViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol UsernameViewDelegate: AnyObject {
    func show(error: String)
    func showLabel(text: String)
    func hideLabel()
    func goToPasswordVC()
}
