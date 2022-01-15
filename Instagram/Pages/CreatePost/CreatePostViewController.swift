//
//  CreateViewController.swift
//  PostFeed
//
//  Created by Yersage on 23.09.2021.
//

import UIKit
import Photos

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var createPostNavigationItem: UINavigationItem!
    
    var presenter: CreatePostPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CreatePostPresenter(view: self)
        postTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "New Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector((nextButtonPressed)))
    }
}

// MARK:- IBAction
extension CreatePostViewController {
    @IBAction func postImagePressed(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

// MARK:- UIImagePickerController
extension CreatePostViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            postImageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK:- UITextViewDelegate
extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write a text..." {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write a text..."
        }
    }
}

// MARK:- stopButtonPressed, nextButtonPressed
extension CreatePostViewController {
    
    @objc func stopButtonPressed() {
        tabBarController?.selectedIndex = 0
    }
    
    @objc func nextButtonPressed() {
        presenter?.uploadPost(image: postImageView.image, caption: postTextView.text)
    }
}

// MARK:- CreatePostViewDelegate
extension CreatePostViewController: CreatePostViewDelegate {
    func showSuccess() {
        let message = "You've successfully created new post."
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToFeedVC() {
        tabBarController?.selectedIndex = 0
    }
    
    
}
