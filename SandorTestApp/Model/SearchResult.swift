//
//  SearchResult.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import Foundation
import RealmSwift

class SearchResult: Object {
    @objc dynamic var searchedWord = ""
    @objc dynamic var imageStringURL = ""
    @objc dynamic var created = Date()
}
