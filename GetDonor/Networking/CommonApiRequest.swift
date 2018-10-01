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
        
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)

        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
    
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> Dictionary<String,Any> {
        
        return try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
    }
    
}
