//
//  MoreVideosDataModel.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct MoreVideosDataModel: Codable {
    
    var vidoeList: [Video]? = []
    var currentPage: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case vidoeList = "node"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
}

