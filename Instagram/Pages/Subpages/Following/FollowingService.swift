//
//  FollowingService.swift
//  PostFeed
//
//  Created by Yersage on 11.11.2021.
//

import Foundation

class FollowingService {
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
