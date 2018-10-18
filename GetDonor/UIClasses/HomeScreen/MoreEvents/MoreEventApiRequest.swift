//
//  MoreEventApiRequest.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation


class MoreEventApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> MoreEventDataModel {
        
        return try JSONDecoder().decode(MoreEventDataModel.self, from: data)
    }
    
}
