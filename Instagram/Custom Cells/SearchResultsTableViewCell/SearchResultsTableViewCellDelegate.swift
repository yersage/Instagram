//
//  SearchResultsTableViewCellDelegate.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import UIKit

protocol SearchResultsTableViewCellDelegate: AnyObject {
    func usernamePressed(_ cell: UITableViewCell)
}
