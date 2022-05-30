//
//  ViewController.swift
//  PostFeed
//
//  Created by Yersage on 10.09.2021.
//

import Foundation
import UIKit

final class FeedViewController: UIViewController, FeedViewDelegate {
    
    let feedTableView = FeedTableView()
    
    var presenter: FeedPresenterDelegate?
    var feedTableViewDelegate: FeedTableViewDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        view = feedTableView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(presenter != nil, "Presenter is nil.")
        
        feedTableViewDelegate = FeedTableViewDelegate(tableView: feedTableView, presenter: presenter!)
        feedTableView.delegate = feedTableViewDelegate
        feedTableView.dataSource = presenter!.dataSource
        
        presenter!.viewDidLoad()
    }
        
    func reloadTableView() {
        self.feedTableView.reloadData()
    }
    
    func reloadRow(at index: Int) {
        feedTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .middle)
    }
    
    func removeSpinners() {
        if (feedTableView.tableHeaderView != nil) {
            feedTableView.tableHeaderView = nil
        }
        if feedTableView.tableFooterView != nil {
            feedTableView.tableFooterView = nil
        }
    }
    
    func createLoader(from position: LoaderPosition) {
        switch position {
        case .top:
            feedTableView.createSpinnerHeader()
        case .bottom:
            feedTableView.createSpinnerFooter()
        }
    }
}
