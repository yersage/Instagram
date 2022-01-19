//
//  WelcomePresenter.swift
//  PostFeed
//
//  Created by Yersage on 05.12.2021.
//

import Foundation

final class WelcomePresenter: WelcomePresenterDelegate {
    weak var view: WelcomeViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()

    func login(username: String, password: String) {
        
    }
}
