//
//  EditProfilePresenterDelegate.swift
//  PostFeed
//
//  Created by Yersage on 09.01.2022.
//

import UIKit

protocol EditProfilePresenterDelegate: AnyObject {
    func putProfileData(image: UIImage, name: String?, website: String?, bio: String?, username: String)
}
