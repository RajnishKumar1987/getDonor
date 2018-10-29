//
//  ArticleDetailsApiRequest.swift
//  GetDonor
//
//  Created by admin on 25/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ArticleDetailsApiRequest: APIRequest{
    
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> ArticleDetailsDataModel {
        return try JSONDecoder().decode(ArticleDetailsDataModel.self, from: data)
    }
}
