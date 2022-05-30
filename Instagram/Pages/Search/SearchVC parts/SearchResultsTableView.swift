//
//  SearchResultsTableView.swift
//  Instagram
//
//  Created by Yersage on 20.04.2022.
//

import Foundation
import UIKit

class SearchResultsTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
