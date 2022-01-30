//
//  SearchPresenter.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import Foundation

final class SearchPresenter: SearchPresenterDelegate {
    weak var view: SearchViewDelegate?
    private let searchService = SearchService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))
    
    func search(by name: String) {
        searchService.searchResults(for: name) { result in
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
