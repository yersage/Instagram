//
//  FeedTableViewDelegate.swift
//  Instagram
//
//  Created by Yersage on 19.04.2022.
//

import Foundation
import UIKit

class FeedTableViewDelegate: NSObject, UITableViewDelegate, UIScrollViewDelegate {
    
    let tableView: FeedTableView
    let presenter: FeedPresenterDelegate
    
    init (tableView: FeedTableView, presenter: FeedPresenterDelegate) {
        self.presenter = presenter
        self.tableView = tableView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.y
                        
        if contentOffset > tableView.contentSize.height - 200 - scrollView.frame.size.height {
            presenter.loaderStarted(from: .bottom)
        }
        
        if contentOffset < -200 {
            presenter.loaderStarted(from: .top)
        }
    }
}
