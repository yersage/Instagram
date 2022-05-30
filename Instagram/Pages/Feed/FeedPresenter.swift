//
//  FeedPresenter.swift
//  PostFeed
//
//  Created by Yersage on 16.10.2021.
//

import Foundation

final class FeedPresenter: FeedPresenterDelegate {
    // MARK:- Initialization
    private let paginationService = PostsPaginationService()
    private let postsService = PostsService(requestService: RequestManager(), interceptor: KeychainSwiftInterceptor(requestService: RequestManager(), tokenService: TokenService()))
    
    weak var view: FeedViewDelegate?
    lazy var dataSource = FeedTableViewDataSource(presenter: self)
    
    var model = FeedModel()
    var coordinator: BasicCoordinator?
    
    func viewDidLoad() {
        self.loaderStarted(from: .top)
    }
    
    func numberOfRowsInSection() -> Int {
        return model.getPostsCount()
    }
    
    func getPost(at index: Int) -> PostModel {
        guard model.getPost(index: index) != nil else { fatalError("Index out of range.") }
        return model.getPost(index: index)!
    }
    
    func loaderStarted(from position: LoaderPosition) {
        
        if paginationService.getIsPaginating() { return }
        paginationService.changeIsPaginating()
        
        view?.createLoader(from: position)
        
        switch position {
        case .top:
            downloadPosts(firstPage: true)
        case .bottom:
            downloadPosts(firstPage: false)
        }
    }
    
    func downloadPosts(firstPage: Bool) {
        
        if firstPage == true {
            self.paginationService.nullifyPage()
        }
        
        let page = self.paginationService.getPage()
        
        postsService.requestPosts(page: page) { result in
            switch result {
            case .success(let newPosts):
                self.view?.removeSpinners()
                self.paginationService.changeIsPaginating()
                self.model.set(newPosts: newPosts, page: page)
                self.view?.reloadTableView()
                self.paginationService.increasePage()
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    func like(like: Bool, postID: Int, index: Int) {
        postsService.like(postID: "\(postID)") { result in
            switch result {
            case .success(let newPost):
                self.model.setPost(post: newPost, index: index)
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    func unlike(like: Bool, postID: Int, index: Int) {
        postsService.unlike(postID: "\(postID)") { result in
            switch result {
            case .success(let newPost):
                self.model.setPost(post: newPost, index: index)
            case .failure(let error):
                if error.localizedDescription != NetworkError.noData.localizedDescription {
                    self.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
}

extension FeedPresenter: PostCellPresenterDelegate {
    func morePressed(postID: Int?) {
        guard postID != nil else { fatalError("PostCell didn't provide postID") }
        model.updateState(postID: postID!, subView: .more)
    }
    
    func likePressed(postID: Int?) {
        
    }
    
    func unlikePressed(postID: Int?) {
        
    }
    
    func savePressed(postID: Int?) {
        
    }
    
    func usernamePressed(userProjection: UserProjection?) {
        guard userProjection != nil else { fatalError("PostCell didn't provide postID") }
        coordinator?.profile(userProjection: userProjection!)
    }
    
    func commentPressed(postID: Int?) {
        
    }
}
