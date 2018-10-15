//
//  MenuDataModel.swift
//  GetDonor
//
//  Created by admin on 21/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct MenuDataModel: Codable {
    var menu: [Menu] = []
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case menu = "node"
        case message
    }
    
}

struct Menu: Codable{
    var type: String?
    var name: String?
    var url: String?
    var text: String?
    
}
