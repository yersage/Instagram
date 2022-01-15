//
//  ChangePropertyViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 08.01.2022.
//

import Foundation

protocol ChangePropertyViewDelegate: AnyObject {
    func hideValidationLabel()
    func showValidationLabel(_ text: String)
    func show(error: String)
}
