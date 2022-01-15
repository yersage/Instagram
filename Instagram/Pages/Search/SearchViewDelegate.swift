//
//  SearchViewDelegate.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    func show(error: String)
    func set(newResults: [ProfileModel])
    func reloadData()
}
