//
//  NetworkService.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import UIKit
import Alamofire

protocol NetworkService {
    func authorize(parameters: [String: Any]?, completion: @escaping (Result<Data, Error>) -> Void)
    func request(_ url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, interceptor: RequestInterceptor?, completion: @escaping (Result<Data, Error>) -> Void)
    func putProfile(context: NetworkContext, image: Data, name: Data?, bio: Data?, website: Data?, username: Data, completion: @escaping (Result<ProfileDataModel, Error>) -> Void)
    func upload(context: NetworkContext, image: Data, caption: Data, completion: @escaping (Result<PostModel, Error>) -> Void)
    func load(context: NetworkContext, completion: @escaping (Result<Int, Error>) -> Void)
    func loadImage(context: NetworkContext, completion: @escaping (Result<UIImage, Error>) -> Void)
    func loadDecodable<T: Decodable>(context: NetworkContext, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
