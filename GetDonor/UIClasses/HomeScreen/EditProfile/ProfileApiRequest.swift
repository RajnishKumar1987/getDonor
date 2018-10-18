//
//  ProfileApiRequest.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ProfileApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]) throws -> URLRequest {
        
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> ProfileDataModel   {
        return try JSONDecoder().decode(ProfileDataModel.self, from: data)
    }
}
