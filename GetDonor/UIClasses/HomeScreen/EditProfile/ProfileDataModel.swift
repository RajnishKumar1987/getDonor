//
//  ProfileDataModel.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct ProfileDataModel: Codable {
    var user: User?
    var message: String?
    
    enum CodingKeys: String,CodingKey  {
        case user = "node"
        case message
    }
    
    
}

struct User: Codable {
    var id: String?
    var email: String?
    var password: String?
    var phone: String?
    var firstname: String?
    var lastname: String?
    var dob: String?
    var state: String?
    var city: String?
    var country: String?
    var b_group: String?
    var property: String?
    var status: String?
    var insertdate: String?
    var image: String?
}
