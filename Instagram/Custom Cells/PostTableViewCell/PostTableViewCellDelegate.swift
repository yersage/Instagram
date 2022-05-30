//
//  FeedTableViewCellDelegate.swift
//  PostFeed
//
//  Created by Yersage on 04.11.2021.
//

import UIKit

//protocol PostTableViewCellDelegate: AnyObject {
//    func morePressed(_ cell: UITableViewCell)
//    func likePressed(_ cell: UITableViewCell, postID: Int?)
//    func unlikePressed(_ cell: UITableViewCell, postID: Int?)
//    func savePressed(_ cell: UITableViewCell)
//    func usernamePressed(_ cell: UITableViewCell)
//    func commentPressed(_ cell: UITableViewCell, postID: Int?)
//}

protocol PostCellPresenterDelegate: AnyObject {
    func morePressed(postID: Int?)
    func likePressed(postID: Int?)
    func unlikePressed(postID: Int?)
    func savePressed(postID: Int?)
    func usernamePressed(userProjection: UserProjection?)
    func commentPressed(postID: Int?)
}
