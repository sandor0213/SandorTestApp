//
//  HTTPClient.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import Foundation

class HTTPClient {
    
    static func searchForImage(searchPhrase: String, callback:@escaping( _ json : [String:Any]?, _ status : Bool)->()) {
        
        let url = (Configuration.restAPIURL + searchPhrase).getURL()
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = Configuration.header
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                callback(nil, false)
                return
            }
            
            guard let data = data else {
                callback(nil, false)
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    callback(json, true)
                }
                
            } catch let error {
                print(error.localizedDescription)
                callback(nil, false)
            }
        })
        
        task.resume()
    }
}


