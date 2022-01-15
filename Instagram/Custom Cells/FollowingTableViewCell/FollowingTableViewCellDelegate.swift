//
//  FollowingTableViewCellDelegate.swift
//  PostFeed
//
//  Created by Yersage on 11.11.2021.
//

import UIKit

protocol FollowingTableViewCellDelegate: AnyObject {
    func usernamePressed(_ cell: UITableViewCell, userID: String?, username: String?)
    func follow()
    func unfollow()
}
