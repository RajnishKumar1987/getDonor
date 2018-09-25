//
//  CommonApiRequest.swift
//  GetDonor
//
//  Created by admin on 07/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class CommonApiRequest: APIRequest {
    
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters:Dictionary<String,String>? = [:]) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        
        let urlComp = URLComponents(string: (url?.absoluteString)!)
        
        if let queryItem = urlComp?.queryItems {
           let result = queryItem.map { (item) -> String in
            return item.value!
            }.joined(separator: "")
            print(result)
        }
        for item in (urlComp?.queryItems)!{
            print(item.value)
        }
        
        
        var urlRequest = URLRequest(url: url!)
        
        if let requestParam = parameters {
            urlRequest.addValue(requestParam.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> Dictionary<String,Any> {
        
        return try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
    }
    
}
