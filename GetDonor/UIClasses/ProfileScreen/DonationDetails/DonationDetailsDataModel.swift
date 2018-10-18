//
//  DonationDetailsDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 05/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct DonationDetailsDataModel: Codable {
    var message: String?
    var transactions: [Transaction] = []
    var usedEndowment: String?
    var totalEndowmant: String?
    
    
    enum CodingKeys: String, CodingKey {
        case message
        case transactions = "node"
        case totalEndowmant = "total_endowment"
        case usedEndowment = "total_endowment_used"
    }
}

struct Transaction: Codable {
    var id: String?
    var txnid: String?
    var amount: String?
    var mode: String?
    var status: String?
    var addedon: String?
    var username: String?
    var receipt: String?
    
    
}
