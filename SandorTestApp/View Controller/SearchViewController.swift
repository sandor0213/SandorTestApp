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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.returnKeyType = .done
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
                    
                    DispatchQueue.main.async {
                        guard let searchResult = SearchResult().createSearchResult(searchedWord: keyword, json: json!) else {return}
                        if searchResult.imageStringURL.isEmpty {self.showAlert(message: Constants.alertEmptyResultText + keyword + Constants.endAlertEmptyResultText)}
                        SearchResult().saveSearchResult(searchResult: searchResult)
                       // update ui
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

extension SearchViewController {
    struct Constants {
        static let alertEmptyResultText = "Sorry, no results were found for \""
        static let endAlertEmptyResultText = "\""
           static let alertNoInternetText = "Internet Connection is not Available!"
        static let maxSearchCharacter = 20
}
}
