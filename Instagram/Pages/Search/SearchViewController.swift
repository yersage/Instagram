//
//  SearchPresenterViewController.swift
//  PostFeed
//
//  Created by Yersage on 04.01.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    private var presenter: SearchPresenterDelegate?
    private var results: [ProfileModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter = SearchPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func layout() {
        searchResultsTableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        searchResultsTableView.separatorStyle = .none
        searchTextField.delegate = self
        searchTextField.placeholder = "Search"
    }
}

// MARK:- SearchResultsTableViewCellDelegate
extension SearchViewController: SearchResultsTableViewCellDelegate {
    func usernamePressed(_ cell: UITableViewCell) {
        guard let indexPath = searchResultsTableView.indexPath(for: cell) else { return }
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.userID = results[indexPath.row].user.id
        
        let backItem = UIBarButtonItem()
        backItem.title = results[indexPath.row].user.username
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
}

// MARK:- UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.userID = results[indexPath.row].user.id
        
        let backItem = UIBarButtonItem()
        backItem.title = results[indexPath.row].user.username
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
}

// MARK:- UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier, for: indexPath) as? SearchResultsTableViewCell else { print("From FollowingVC: error dequeuing cell."); return UITableViewCell() }
        
        cell.delegate = self
        cell.profileModel = results[indexPath.row]
        
        return cell
    }
}

// MARK:- UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        }
        
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.search(by: textField.text!)
    }
}

// MARK:- SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func set(newResults: [ProfileModel]) {
        results = newResults
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        searchResultsTableView.reloadData()
    }
}
