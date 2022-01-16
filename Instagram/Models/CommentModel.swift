//
//  CommentModel.swift
//  PostFeed
//
//  Created by Yersage on 16.09.2021.
//

import Foundation

struct CommentModel: Codable {
    let commentProjection: CommentProjection
    let commentMetaData: CommentMetaData
}

struct CommentProjection: Codable {
    let id: Int
    let content: String
    let repliedToComment: RepliedToCommentModel?
    let author: String
    let created: String
    let parentComment: ParentCommentModel?
    let numberOfLikes: Int
    let authorId: String
    let numberOfChildrenComments: Int
}

struct CommentMetaData: Codable {
    let isCommentLikedByCurrentUser: Bool
}

struct RepliedToCommentModel: Codable {
    let id: Int
    let author: String
    let authorId: String
}

struct ParentCommentModel: Codable {
    let id: Int
    let author: String
    let authorId: String
}
