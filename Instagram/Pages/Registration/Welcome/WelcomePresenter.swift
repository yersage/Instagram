//
//  WelcomePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

class WelcomePresenter: WelcomePresenterDelegate {
    private let view: WelcomeViewDelegate
    private let networkService: NetworkService = NetworkAdapter()
    
    init(view: WelcomeViewDelegate) {
        self.view = view
    }
    
    func login(username: String, password: String) {
        
    }
}
