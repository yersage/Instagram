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
        guard let image = image.pngData() else { return }
        let name = name?.data(using: .utf8)
        let website = website?.data(using: .utf8)
        let bio = bio?.data(using: .utf8)
        guard let username = username.data(using: .utf8) else { return }
        
        networkManager.request(InstagramEndPoint.editProfile(image: image, name: name, website: website, bio: bio, username: username), model: ProfileDataModel.self) { result in
            switch result {
            case .success(let profileModel):
                print(profileModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
