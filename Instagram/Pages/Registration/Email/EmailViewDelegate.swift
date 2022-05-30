//
//  EmailViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

protocol EmailViewDelegate: AnyObject {
    func show(error: String)
    func updateLabel(isHidden: Bool, text: String?)
}
