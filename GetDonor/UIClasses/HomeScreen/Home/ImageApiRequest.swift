//
//  ImageApiRequest.swift
//  GetDonor
//
//  Created by admin on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

class ImageRequest: APIRequest {
    
    var shouldCache: Bool = true
    
    init(shouldCache: Bool = true) {
        self.shouldCache = shouldCache
    }
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: Dictionary<String,String>? = [:]) throws -> URLRequest {
        
        //let urlString = function.urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var urlRequest = URLRequest(url: URL(string: "https://www.getdonor.org")!)
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString , parameters: parameters)
        if let url = url {
            urlRequest = URLRequest(url: url)
            
        }
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> UIImage {
        
        return UIImage(data: data) ?? UIImage()
    }
    
    func shouldCacheResponse() -> Bool {
        return shouldCache
    }
}


