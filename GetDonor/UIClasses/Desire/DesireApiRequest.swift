//
//  DesireApiRequest.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class DesireApiRequest: APIRequest {
    
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        
        let url = try? URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        
        var urlRequest = URLRequest(url: url!)
        
        if let requestParam = parameters {
            urlRequest.addValue(requestParam.md5WithSecretKey, forHTTPHeaderField: "Authorization")
        }
        return urlRequest

    }
    
    func parseResponse(data: Data) throws -> DesireModel {
        
        
//        var jsonData = Data()
//
//
//        if let path = Bundle.main.path(forResource: "Desire", ofType: "json") {
//            do {
//                jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
//                print(jsonResult)
//
//            } catch {
//                // handle error
//            }
//        }

        return try JSONDecoder().decode(DesireModel.self, from: data)

    }
}
