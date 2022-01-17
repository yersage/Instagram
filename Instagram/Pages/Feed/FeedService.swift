//
//  FeedModel.swift
//  PostFeed
//
//  Created by Yersage on 06.11.2021.
//

import Foundation

final class FeedService {
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
