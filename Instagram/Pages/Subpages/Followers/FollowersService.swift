//
//  FollowersService.swift
//  PostFeed
//
//  Created by Yersage on 20.10.2021.
//

import UIKit

class FollowersService {
    private var page: Int = 0
    private var isPaginating: Bool = false
    
    func getPage() -> Int {
        return page
    }
    
    func getIsPaginating() -> Bool {
        return isPaginating
    }
    
    func changeIsPaginating() {
        isPaginating = !isPaginating
    }
    
    func increasePage() {
        page += 1
    }
    
    func nullifyPage() {
        page = 0
    }
}
