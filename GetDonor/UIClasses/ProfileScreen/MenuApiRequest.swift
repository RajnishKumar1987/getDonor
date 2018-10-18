//
//  MenuApiRequest.swift
//  GetDonor
//
//  Created by Rajnish kumar on 21/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class MenuApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String: String]?) throws -> URLRequest {
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> MenuDataModel {
//                        var jsonData = Data()
//                        if let path = Bundle.main.path(forResource: "Menu", ofType: "json") {
//                            do {
//                                jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
//                                print(jsonResult)
//
//                            } catch {
//                                // handle error
//                            }
//                        }
        
        return try JSONDecoder().decode(MenuDataModel.self, from: data)
    }
}

