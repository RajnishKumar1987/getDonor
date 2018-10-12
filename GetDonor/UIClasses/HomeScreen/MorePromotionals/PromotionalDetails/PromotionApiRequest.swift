//
//  PromotionApiRequest.swift
//  GetDonor
//
//  Created by admin on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class PromotionApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters:Dictionary<String,String>? = [:]) throws -> URLRequest {
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> PromotionDatatModel {
        
//        var jsonData = Data()
//        if let path = Bundle.main.path(forResource: "PromotionDetails", ofType: "json") {
//            do {
//                jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
//                print(jsonResult)
//
//            } catch {
//                // handle error
//            }
//        }
        return try JSONDecoder().decode(PromotionDatatModel.self, from: data)
    }
}
