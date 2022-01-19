//
//  SearchPresenter.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import Foundation

final class SearchPresenter: SearchPresenterDelegate {
    weak var view: SearchViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()
    
    func search(by name: String) {
        networkManager.request(InstagramEndPoint.search(name: name), model: [ProfileModel].self) { result in
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
