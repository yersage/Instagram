//
//  FeedTableViewDataSource.swift
//  Instagram
//
//  Created by Yersage on 18.04.2022.
//

import Foundation
import UIKit

class FeedTableViewDataSource: NSObject, UITableViewDataSource {
    
    let presenter: FeedPresenterDelegate & PostCellPresenterDelegate
    
    init (presenter: FeedPresenterDelegate & PostCellPresenterDelegate) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { print("FeedVC: Error dequeuing FeedTableViewCell."); return UITableViewCell() }
        
        cell.presenter = presenter
        cell.set(presenter.getPost(at: indexPath.row))
//        cell.set(postsState[indexPath.row])
        
        return cell
    }
}
