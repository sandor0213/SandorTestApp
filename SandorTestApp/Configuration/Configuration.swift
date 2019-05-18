//
//  Configuration.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import Foundation

final class Configuration {
    static let restAPIURL = "https://api.gettyimages.com/v3/search/images?page_size=1&phrase="
    static let headerAuthKeyword = "Api-Key"
    static let apiKey = "z4pn22dn47rc7bsjw4jwxv9q"
    static let header = [Configuration.headerAuthKeyword : Configuration.apiKey]
    static let initialViewName = "SearchView"
}

