//
//  EditProfileViewController.swift
//  PostFeed
//
//  Created by Yersage on 06.10.2021.
//

import UIKit

final class EditProfileViewController: UIViewController, EditProfileViewDelegate {
    
    @IBOutlet weak var bioButton: UIButton!
    @IBOutlet weak var nameButon: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var profileImageView: CachedImageView!
    
    private let presenter: EditProfilePresenterDelegate
    
    init?(presenter: EditProfilePresenterDelegate, coder: NSCoder) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(product:coder:)")
    required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }
    
    var dictionary: [String: String?] = [:]
    
    var bio: String?
    var name: String?
    var website: String?
    var username: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        setupSubviews()
    }
    
    private func layoutSubviews() {
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    private func setupSubviews() {
        profileImageView.loadImagesFromUserID(userID: UserDefaultsManager.shared.getUserID())
        bioButton.setTitle(bio ?? "Bio", for: .normal)
        nameButon.setTitle(name ?? "Name", for: .normal)
        usernameButton.setTitle(username, for: .normal)
        websiteTextField.placeholder = website
        
        dictionary["Bio"] = bio
        dictionary["Name"] = name
        dictionary["Username"] = username
    }
    
    @IBAction func changeProfilePhotoPressed(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        presenter.putProfileData(image: profileImageView.image!, name: dictionary["Name"]!, website: websiteTextField.text ?? websiteTextField.placeholder, bio: dictionary["Bio"]!, username: dictionary["Username"]!!)
    }
    
    @IBAction func propertyButtonPressed(_ sender: UIButton) {
        let changeDataVC = self.storyboard!.instantiateViewController(withIdentifier: "ChangeDataViewController") as! ChangePropertyViewController
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: changeDataVC, action: #selector(changeDataVC.doneButtonPressed))
        changeDataVC.navigationItem.rightBarButtonItem = done
        if let key = dictionary.first(where: { $0.value == sender.currentTitle! })?.key {
            changeDataVC.property = key
        }
        
        changeDataVC.value = sender.currentTitle!
        changeDataVC.completionHandler = { property in
            self.dictionary[changeDataVC.property!] = property
            sender.setTitle(property, for: .normal)
        }
        self.navigationController!.pushViewController(changeDataVC, animated: true)
    }
    
}

// MARK:- UIImagePickerController
extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
