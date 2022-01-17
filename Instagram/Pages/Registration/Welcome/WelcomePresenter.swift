//
//  WelcomePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

class WelcomePresenter: WelcomePresenterDelegate {
    weak var view: WelcomeViewDelegate?
    private let networkService: NetworkService = NetworkAdapter()

    func login(username: String, password: String) {
        
    }
}
