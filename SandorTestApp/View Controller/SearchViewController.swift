//
//  SearchViewController.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchResults = SearchResult.getSearchResults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.returnKeyType = .done
        self.searchTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: Constants.searchResultCellRI)
        hideKeyboardWhenTappedAround()
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard Reachability.isConnectedToNetwork() else {
            self.showAlert(message: Constants.alertNoInternetText)
            return
        }
        
        guard let keyword = searchBar.text else {return }
        DispatchQueue.global(qos: .background).async {
            
            HTTPClient.searchForImage(searchPhrase: keyword, callback: { (json, status) in
                if status {
                    guard let searchResult = SearchResult.createSearchResult(searchedWord: keyword, json: json!) else {return}
                    if searchResult.imageStringURL.isEmpty {self.showAlert(message: Constants.alertEmptyResultText + keyword + Constants.endAlertEmptyResultText)}
                    SearchResult.saveSearchResult(searchResult: searchResult)
                    
                    DispatchQueue.main.async {
                        guard let searchResults = SearchResult.getSearchResults() else {return}
                        self.searchResults = searchResults
                        self.searchTableView.reloadData()
                        self.viewDidLayoutSubviews()
                    }
                    
                } else {
                    self.showAlert(message: Constants.alertEmptyResultText + keyword + Constants.endAlertEmptyResultText)
                }
            })
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        let text = (isBackSpace == -92) ? String(searchBar.text!.dropLast()) : searchBar.text! + text
        self.showAlert(message: text.checkMaxCharacters())
        return text.count <= Constants.maxSearchCharacter
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UItableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults != nil ? searchResults!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchResultCellRI) as! SearchResultTableViewCell
        cell.setUp(searchedWord: self.searchResults![indexPath.row].searchedWord, searchImageStringURL: self.searchResults![indexPath.row].imageStringURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            SearchResult.removeSearchResult(searchResult: self.searchResults![indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .none)
            self.viewDidLayoutSubviews()
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.searchTableView.isScrollEnabled = (Constants.heightForRowAt * CGFloat(searchResults!.count)) > self.searchTableView.frame.size.height
    }
    
}


extension SearchViewController {
    struct Constants {
        static let searchResultCellRI = "SearchResultTableViewCell"
        static let alertEmptyResultText = "Sorry, no results were found for \""
        static let endAlertEmptyResultText = "\""
        static let alertNoInternetText = "Internet Connection is not Available!"
        static let heightForRowAt: CGFloat = 44
        static let maxSearchCharacter = 20
    }
    
}
