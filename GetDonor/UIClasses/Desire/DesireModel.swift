//
//  DesireModel.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct DesireModel: Codable {
    
    
    var node: Container
    
}

struct Container: Codable {
    var corousal:  [String]? = []
    var vision: [String]?
    var objective: [String]?
    var mission: [String]?
    
    enum CodingKeys: String, CodingKey {
        case corousal 
        case vision = "our_vision"
        case objective = "our_objective"
        case mission = "our_mission"
    }
    
}



