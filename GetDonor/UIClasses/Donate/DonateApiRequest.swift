//
//  DonateApiRequest.swift
//  GetDonor
//
//  Created by Rajnish kumar on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class DonateApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:String]?) throws -> URLRequest {
        let url = try URLEncoder().urlWith(urlString: function.urlString, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(url.getMD5WithSceretKey(), forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> DonateDataModel {
//                var jsonData = Data()
//
//
//                if let path = Bundle.main.path(forResource: "Donate", ofType: "json") {
//                    do {
//                        jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                        let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
//                        print(jsonResult)
//
//                    } catch {
//                        // handle error
//                    }
//                }
        
        return try JSONDecoder().decode(DonateDataModel.self, from: data)

    }
}
