//
//  LoginDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct LoginDataModel:Codable {
    
    var message: String?
    var userDetails: UserDetails?
    
    enum CodingKeys: String, CodingKey {
        case message
        case userDetails = "node"
    }
    
}

struct UserDetails: Codable {
    var userName: String?
    var userId: String?
    var shouldShowUpdateFrofile: Bool
    var profilePic: String?
    
    enum CodingKeys: String,CodingKey {
        case userName = "username"
        case userId = "user_id"
        case shouldShowUpdateFrofile = "update_profile"
        case profilePic = "image"
    }

}




