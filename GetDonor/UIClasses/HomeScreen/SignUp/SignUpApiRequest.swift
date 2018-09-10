//
//  SignUpApiRequest.swift
//  GetDonor
//
//  Created by admin on 07/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class SignUpApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url!)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)

        urlRequest.httpBody = jsonAsData

        urlRequest.addValue(parameters.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> Dictionary<String,Any> {
        
        return try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
    }
}
