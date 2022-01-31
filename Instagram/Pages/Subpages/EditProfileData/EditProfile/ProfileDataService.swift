//
//  ProfileDataService.swift
//  Instagram
//
//  Created by Yersage on 31.01.2022.
//

import Foundation
import Alamofire

class ProfileDataService {
    private let uploadService: UploadDelegate
    private let interceptor: RequestInterceptor
    
    init(uploadService: UploadDelegate, interceptor: RequestInterceptor) {
        self.uploadService = uploadService
        self.interceptor = interceptor
    }
    
    func putProfile(image: Data, name: Data?, website: Data?, bio: Data?, username: Data, completion: @escaping (Result<ProfileDataModel, Error>) -> ()) {
        let formDataParts = [
            FormData(data: image, withName: "image", fileName: "image.png", mimeType: "image/png"),
        ]
        
        uploadService.upload(InstagramEndPoint.editProfile(image: image, name: name, website: website, bio: bio, username: username), interceptor: interceptor, formDataParts: formDataParts) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NetworkError.noData)); return }
            
            do {
                let newProfile = try JSONDecoder().decode(ProfileDataModel.self, from: data)
                completion(.success(newProfile))
            } catch {
                completion(.failure(NetworkError.dataLoad))
            }
        }
    }
}
