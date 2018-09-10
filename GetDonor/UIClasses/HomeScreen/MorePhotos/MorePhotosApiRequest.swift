//
//  MorePhotosApiRequest.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class MorePhotosApiRequest: APIRequest {

    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        
        var urlRequest = URLRequest(url: url!)
        
        if let requestParam = parameters {
            urlRequest.addValue(requestParam.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
        
    }
    
    func parseResponse(data: Data) throws -> MorePhotosDataModel {
        
        return try JSONDecoder().decode(MorePhotosDataModel.self, from: data)
    }
    
}
