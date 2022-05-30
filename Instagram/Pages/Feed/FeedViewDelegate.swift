//
//  FeedViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 16.10.2021.
//

import Foundation

protocol FeedViewDelegate: NSObjectProtocol {    
    func removeSpinners()
    func show(error: String)
    func reloadTableView()
    func reloadRow(at index: Int)
    func createLoader(from position: LoaderPosition)
}
