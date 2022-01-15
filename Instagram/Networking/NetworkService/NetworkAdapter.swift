//
//  NetworkAdapter.swift
//  PostFeed
//
//  Created by Yersage on 27.10.2021.
//

import Foundation
import Alamofire

class NetworkAdapter: NetworkService {    
    
    private let interceptor = Interceptor()
    private let retryLimit = 3
    private let loginAddress = "http://localhost:8090/auth/login"
    private let refreshAddress = "http://localhost:8090/auth/refresh-token"
    var request: Alamofire.Request?
    
    func authorize(parameters: [String: Any]?, completion: @escaping (Result<Data, Error>) -> Void) {
        request?.cancel()
        request = AF.request(loginAddress, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(response.error!))
            }
        }
    }
    
    func request(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers,
                   interceptor: interceptor).validate().responseJSON { (response) in
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(response.error!))
            }
        }
    }
    
    func putProfile(context: NetworkContext, image: Data, name: Data?, bio: Data?, website: Data?, username: Data, completion: @escaping (Result<ProfileDataModel, Error>) -> Void) {
        guard let url = context.url else {
            completion(.failure(NetworkError.urlValid))
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "image", fileName: "image.png", mimeType: "image/png")
            if name != nil {
                multipartFormData.append(name!, withName: "name")
            }
            if bio != nil {
                multipartFormData.append(bio!, withName: "bio")
            }
            if website != nil {
                multipartFormData.append(website!, withName: "website")
            }
            multipartFormData.append(username, withName: "username")
        }, to: url, method: .put, interceptor: interceptor).responseData { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            guard let data = response.data else { completion(.failure(NetworkError.dataLoad)); return }
            do {
                let profileDataModel = try JSONDecoder().decode(ProfileDataModel.self, from: data)
                completion(.success(profileDataModel))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    func upload(context: NetworkContext, image: Data, caption: Data, completion: @escaping (Result<PostModel, Error>) -> Void) {
        guard let url = context.url else {
            completion(.failure(NetworkError.urlValid))
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(caption, withName: "caption")
            multipartFormData.append(image, withName: "images", fileName: "image.png", mimeType: "image/png")
        }, to: url, method: .post, interceptor: interceptor).responseJSON { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            guard let data = response.data else { completion(.failure(NetworkError.dataLoad)); return }
            do {
                let post = try JSONDecoder().decode(PostModel.self, from: data)
                completion(.success(post))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
    
    func load(context: NetworkContext, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = context.url else {
            completion(.failure(NetworkError.urlValid))
            return
        }
        
        AF.request(
            url,
            method: httpMethod(method: context.method),
            parameters: context.parameters,
            encoding: encoding(encoding: context.encoding)
        ).responseJSON { response in
            if let statusCode = response.response?.statusCode {
                completion(.success(statusCode))
            } else {
                completion(.failure(NetworkError.unknown))
            }
        }
    }
    
    func loadDecodable<T: Decodable>(context: NetworkContext, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        loadResponse(context: context) { networkResponse in
            if let error = networkResponse.networkError {
                completion(.failure(error))
                return
            }
            guard let result: T = networkResponse.decode() else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(result))
        }
    }
    
    func loadImage(context: NetworkContext, completion: @escaping (Result<UIImage, Error>) -> Void) {
        loadImageData(context: context) { networkResponse in
            if let error = networkResponse.networkError {
                completion(.failure(error))
                return
            }
            guard let image = UIImage(data: networkResponse.data!) else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(image))
        }
    }
}

extension NetworkAdapter {
    private func loadResponse(context: NetworkContext, completion: @escaping (NetworkResponse) -> Void) {
        guard let url = context.url else {
            completion(FailureNetworkResponse(networkError: .urlValid))
            return
        }
        
        AF.request(
            url,
            method: httpMethod(method: context.method),
            parameters: context.parameters,
            encoding: encoding(encoding: context.encoding),
            interceptor: interceptor
        ).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            completion(strongSelf.dataResponseToNetworkResponse(response: response))
        }
    }
    
    private func loadImageData(context: NetworkContext, completion: @escaping (NetworkResponse) -> Void) {
        guard let url = context.url else {
            completion(FailureNetworkResponse(networkError: .urlValid))
            return
        }
        
        AF.request(
            url,
            method: httpMethod(method: context.method),
            parameters: context.parameters,
            encoding: encoding(encoding: context.encoding),
            interceptor: interceptor
        ).responseData { response in
            if let serverError = response.error {
                completion(FailureNetworkResponse(networkError: .serverError(description: serverError.localizedDescription)))
                return
            }
            
            completion(SuccessNetworkResponse(data: response.data))
        }
    }
    
    private func dataResponseToNetworkResponse(response: DataResponse<Any, AFError>) -> NetworkResponse {
        if let serverError = response.error {
            return FailureNetworkResponse(networkError: .serverError(description: serverError.localizedDescription))
        }
        
        return SuccessNetworkResponse(data: response.data)
    }
    
    private func httpMethod(method: NetworkMethod) -> HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
    
    private func encoding(encoding: NetworkEncoding) -> ParameterEncoding {
        switch encoding {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}
