//
//  FeedModel.swift
//  Instagram
//
//  Created by Yersage on 18.04.2022.
//

import Foundation

class FeedModel {
    
    var posts = [PostModel]()
    var postsState = [Int: PostState]()
    
//    init (posts: [PostModel]) {
//        self.posts = posts
//    }
    
    func getPostsCount() -> Int {
        return posts.count
    }
    
    func getPost(index: Int) -> PostModel? {
        return index < posts.count ? posts[index] : nil
    }
    
    func setPost(post: PostModel, index: Int) {
        posts[index] = post
    }
    
    func set(newPosts: [PostModel], page: Int) {
        for newPost in newPosts {
            postsState[newPost.post.id] = PostState(isMorePressed: false, isSavePressed: false)
        }
        if page == 0 {
            posts = newPosts
        } else {
            posts += newPosts
        }
    }
    
    func updateState(postID: Int, subView: PostSubviews) {
        guard postsState[postID] != nil else { fatalError("No such postState with postID - \(postID)") }
        
        switch subView {
        case .more:
            postsState[postID]?.isMorePressed = !postsState[postID]!.isMorePressed
        default:
            postsState[postID]?.isSavePressed = !postsState[postID]!.isSavePressed
        }
    }
}

enum PostSubviews {
    case more
    case save
}
