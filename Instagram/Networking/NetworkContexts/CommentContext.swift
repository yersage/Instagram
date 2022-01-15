//
//  CommentContext.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation

class CommentUnlikeContext: NetworkContext {
    var route: InstagramRoute { return .commentUnlike }
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(commentID: Int) {
        parameters["id"] = commentID
    }
}

class CommentLikeContext: NetworkContext {
    var route: InstagramRoute { return .commentLike }
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(commentID: Int) {
        parameters["id"] = commentID
    }
}

class CommentsContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(postID: Int, page: Int) {
        route = .comments(page: page, postID: postID)
    }
}

class ShowCommentRepliesContext: NetworkContext {
    let route: InstagramRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(commentID: Int, page: Int) {
        route = .showCommentReplies(commentID: commentID, page: page)
    }
}

class PostCommentContext: NetworkContext {
    var route: InstagramRoute { return .postComment }
    var method: NetworkMethod { return .post }
    var parameters = [String: Any]()
    
    init(postID: Int, commentID: Int?, content: String) {
        parameters["postId"] = postID
        parameters["commentIdRepliedTo"] = commentID
        parameters["content"] = content
    }
}
