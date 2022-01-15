//
//  FollowersTableViewCellDelegate.swift
//  PostFeed
//
//  Created by Yersage on 10.11.2021.
//

import UIKit

protocol FollowersTableViewCellDelegate: AnyObject {
    func followPressed(_ cell: UITableViewCell)
    func removePressed(_ cell: UITableViewCell, postID: Int?)
    func usernamePressed(_ cell: UITableViewCell, userID: String?, username: String?)
}
