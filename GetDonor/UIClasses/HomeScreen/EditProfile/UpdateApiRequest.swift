//
//  UpdateApiRequest.swift
//  GetDonor
//
//  Created by admin on 19/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

class UpdateProfileApiRequest: APIRequest {
    
    func makeRequest(forFuncion function: Api_EndPoint, parameters: [String:Any]) throws -> URLRequest {
        let url = try? URLEncoder().urlWith(urlString: function.urlString, parameters: nil)
        var urlRequest = URLRequest(url: url!)
        var image = UIImage()
        if let img = parameters["image"] as? UIImage {
            image = img
        }
        var inputParam = parameters
        inputParam["image"] = ""
        urlRequest.httpMethod = "POST"
        let str = AppBaseURLs.apiSecretKey + AppConfig.getUserId() + "SET"
        urlRequest.addValue(str.utf8.md5.description, forHTTPHeaderField: "Authorization")
        let boundary = generateBoundaryString()
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try createBody(with: inputParam as? [String : String], filePathKey: "image", image: image, boundary: boundary)

        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> ProfileDataModel   {
        return try JSONDecoder().decode(ProfileDataModel.self, from: data)
    }
    
    private func createBody(with parameters: [String: String]?, filePathKey: String, image: UIImage, boundary: String) throws -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                if(key != "image"){
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
                }
            }
        }
        
        if let data = UIImageJPEGRepresentation(image, 0) {
            let filename = "user-profile.jpg"
            let mimetype = "image/jpg"
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        body.append("--\(boundary)--\r\n")
        return body
    }
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}
