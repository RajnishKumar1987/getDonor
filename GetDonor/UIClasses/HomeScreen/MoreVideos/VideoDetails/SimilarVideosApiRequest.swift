//
//  SimilarVideosApiRequest.swift
//  GetDonor
//
//  Created by admin on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class SimilarVideosApiRequest: APIRequest {
    
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString , parameters: parameters)
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.addValue(parameters.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        
        return urlRequest
        
        
    }
    

    
    func parseResponse(data: Data) throws -> SimilarVideosDataModel {
        
        return try JSONDecoder().decode(SimilarVideosDataModel.self, from: data)
    }
}
