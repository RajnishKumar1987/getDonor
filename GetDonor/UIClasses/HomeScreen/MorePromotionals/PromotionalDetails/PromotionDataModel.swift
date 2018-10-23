//
//  PromotionDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct PromotionDatatModel: Codable {
    var message: String?
    var response: PromotionDetails?
    
    enum CodingKeys: String, CodingKey {
        case message
        case response = "node"
    }
}

struct PromotionDetails: Codable {
    var id: String?
    var title: String?
    var image: String?
    var extraData: PromotionData?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case extraData = "data"
    }
}

struct PromotionData: Codable {
    var image: [ContentList] = []
    var text: String?
    var insertdate: String?
    var updatedate: String?
    var priority: String?
    var status: String?
    var video: [ContentList] = []    
}

struct ContentList: Codable {
    var image: String?
    var videoid: String?
    var id: String?
    var title: String?
    
}



