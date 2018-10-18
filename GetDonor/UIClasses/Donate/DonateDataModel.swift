//
//  DonateDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct DonateDataModel: Codable {
    var response: DonationDetails?
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case response = "node"
        case message
    }
}

struct DonationDetails: Codable {
    var description: Description?
    var upiDetails: Description?
    var bankDetails: BankDetails?
    var cashDetails: Description?
    var qa: [QandA]?
    var security: Description?
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case upiDetails = "upi_detail"
        case bankDetails = "bank_detail"
        case cashDetails = "cash_detail"
        case qa = "q&a"
        case security = "secure_payment"
    }
}


struct Description:Codable {
    var info: String?
}
struct QandA: Codable {
    var question: String?
    var answer: String
}
struct BankDetails: Codable {
    var info: String?
    var accountName: String?
    var bankName: String?
    var accountNumber: String?
    var ifscCode: String?
    
    enum CodingKeys: String, CodingKey {
        case info
        case accountName = "account_name"
        case bankName = "bank_name"
        case accountNumber = "account_number"
        case ifscCode = "ifsc_code"
    }

}
