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
        urlRequest.addValue(parameters.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> LoginDataModel {
        
        return try JSONDecoder().decode(LoginDataModel.self, from: data)
    }
}
