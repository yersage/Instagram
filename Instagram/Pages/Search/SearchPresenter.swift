//
//  SearchPresenter.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import Foundation

final class SearchPresenter: SearchPresenterDelegate {
    private let networkService: NetworkService = NetworkAdapter()
    weak var view: SearchViewDelegate?
    
    func search(by name: String) {
        networkService.loadDecodable(context: SearchEndPoint(name: name), type: [ProfileModel].self) { result in
            switch result {
            case .success(let searchResult):
                self.view?.set(newResults: searchResult)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
    
    
}
