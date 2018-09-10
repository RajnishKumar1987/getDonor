//
//  MoreEventApiRequest.swift
//  GetDonor
//
//  Created by admin on 10/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation


class MoreEventApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        
        var urlRequest = URLRequest(url: url!)
        
        if let requestParam = parameters {
            urlRequest.addValue(requestParam.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> MoreEventDataModel {
        
        return try JSONDecoder().decode(MoreEventDataModel.self, from: data)
    }
    
}
