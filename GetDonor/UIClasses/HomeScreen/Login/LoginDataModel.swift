//
//  LoginDataModel.swift
//  GetDonor
//
//  Created by admin on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct LoginDataModel:Codable {
    
    var userName: String?
    var userId: String?
    
    enum CodingKeys: String,CodingKey {
        case userName = "username"
        case userId = "user_id"
    }
    
    
}
