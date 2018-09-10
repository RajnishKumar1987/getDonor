//
//  ArticalsDataModel.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct ArticalsDataModel: Codable {
    
    var articalList: [Article]? = []
    var currentPage: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case articalList = "node"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
}
