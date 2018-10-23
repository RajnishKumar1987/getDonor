//
//  DesireModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct DesireModel: Codable {
    
    
    var response: Response
    
    enum CodingKeys: String, CodingKey {
        case response = "node"
    }
    
    
}

struct Response: Codable {
    var corousal: [ContentDataModel]? = []
    var textBody: [BodyText]? = []
    
    enum CodingKeys: String, CodingKey {
        case corousal = "carousal"
        case textBody = "text_body"
    }
    
}


struct BodyText: Codable {
    
    var headerText: String?
    var descriptiontext: [String]?
    
    enum CodingKeys: String, CodingKey {
        case headerText = "headerText"
        case descriptiontext = "descriptionText"
    }
    
    
    
}



