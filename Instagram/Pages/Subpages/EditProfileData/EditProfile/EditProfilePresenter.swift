//
//  EditProfilePresenter.swift
//  PostFeed
//
//  Created by Yersage on 09.01.2022.
//

import UIKit

final class EditProfilePresenter: EditProfilePresenterDelegate {
    weak var view: EditProfileViewDelegate?
    private let networkManager: NetworkManager = NetworkManager()
    
    func putProfileData(image: UIImage, name: String?, website: String?, bio: String?, username: String) {
        let imageData = image.pngData()
        
            networkService.putProfile(endPoint: EditProfileEndPoint(name: name, website: website, bio: bio, username: username), image: imageData!, name: name?.data(using: .utf8), bio: bio?.data(using: .utf8), website: website?.data(using: .utf8), username: username.data(using: .utf8)!) { result in
            switch result {
            case .success(let profileModel):
                print(profileModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
