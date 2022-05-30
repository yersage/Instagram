//
//  FeedTableView.swift
//  Instagram
//
//  Created by Yersage on 18.04.2022.
//

import Foundation
import UIKit

class FeedTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        allowsMultipleSelection = false
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        rowHeight = UITableView.automaticDimension
        register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSpinnerHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = headerView.center
        headerView.addSubview(spinner)
        spinner.startAnimating()
        tableHeaderView = headerView
    }
    
    func createSpinnerFooter() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        tableFooterView = footerView
    }
}
