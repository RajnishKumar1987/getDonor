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
    
    
    func makeRequest(from requestParam: [String: String]) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: AppBaseURLs.baseUrl + "home.php", parameters: requestParam)
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.addValue(requestParam.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        return urlRequest
        
        
    }
    
    func parseResponse(data: Data) throws -> HomeListingModel {
        
        return try JSONDecoder().decode(HomeListingModel.self, from: data)
        
    }
    
}

class ImageRequest: APIRequest {
    
    func makeRequest(from imagePath: String) throws -> URLRequest {
        
        let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlRequest = URLRequest(url: URL(string: urlString!)!)
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> UIImage {
        
        return UIImage(data: data) ?? UIImage()
    }
    
    func shouldCacheResponse() -> Bool {
        return true
    }
}
