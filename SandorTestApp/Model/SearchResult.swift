//
//  SearchResult.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class SearchResult: Object, Mappable {
    
    @objc dynamic var searchedWord = ""
    @objc dynamic var imageStringURL = ""
    @objc dynamic var created = Date()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        imageStringURL <- map["images.0.display_sizes.0.uri"]
    }
    
    func createSearchResult(searchedWord: String, json: [String:Any]) -> SearchResult? {
        guard let searchResult = Mapper<SearchResult>().map(JSON: json as! [String : Any]) else {return nil}
        searchResult.searchedWord = searchedWord
        return searchResult
    }
    
    func saveSearchResult(searchResult: SearchResult?){
        DispatchQueue.main.async {
            guard let searchResult = searchResult else {return}
            if searchResult.imageStringURL.isEmpty {return}
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(searchResult)
                }
                
            } catch let error as NSError {
            }
        }
    }
    
    static func getSearchResults() -> Results<SearchResult>? {
        do {
            let realm = try Realm()
            let searchResults = realm.objects(SearchResult.self).sorted(byKeyPath: Constants.sortedByKeyPath, ascending: false)
            return searchResults
        } catch let error as NSError {
            return nil
        }
    }
    
}

extension SearchResult {
    struct Constants {
        static var sortedByKeyPath = "created"
    }
    
}

