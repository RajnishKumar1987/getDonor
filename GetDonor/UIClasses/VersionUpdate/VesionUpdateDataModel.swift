//
//  VesionUpdateDataModel.swift
//  GetDonor
//
//  Created by admin on 29/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct VersionUpdateDataModel: Codable {
    
    var shouldShowUpDatePopUp: Bool?
    var shouldForceUpdate: Bool?
    var message: String?
    var updateBehaviour: String?
    var updateFrequency: Int?
    
    enum CodingKeys: String, CodingKey {
        case shouldShowUpDatePopUp = "show_pop_up"
        case shouldForceUpdate = "force_update"
        case message
        case updateBehaviour
        case updateFrequency
    }
    
}
