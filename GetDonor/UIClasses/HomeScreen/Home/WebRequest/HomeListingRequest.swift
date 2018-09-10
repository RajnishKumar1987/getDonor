//
//  HomeListingRequest.swift
//  GetDonor
//
//  Created by admin on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

class HomeListingRequest: APIRequest {
    
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString , parameters: parameters)
        
        var urlRequest = URLRequest(url: url!)
        
        if let requestParam = parameters {
            urlRequest.addValue(requestParam.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
        
        
    }
    
    func parseResponse(data: Data) throws -> HomeListingModel {
        
        return try JSONDecoder().decode(HomeListingModel.self, from: data)
        
    }
    
}

class ImageRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: Dictionary<String,String>? = [:]) throws -> URLRequest {
        
        let urlRequest = URLRequest(url: URL(string: function.urlString)!)
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> UIImage {
        
        return UIImage(data: data) ?? UIImage()
    }
    
    func shouldCacheResponse() -> Bool {
        return true
    }
}
