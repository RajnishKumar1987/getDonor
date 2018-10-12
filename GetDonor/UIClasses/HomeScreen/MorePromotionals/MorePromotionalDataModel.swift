//
//  MorePromotionalDataModel.swift
//  GetDonor
//
//  Created by admin on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct MorePromotionalDataModel: Codable {
    
    var promotionalList: [ContentDataModel] = []
    var currentPage: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case promotionalList = "node"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
    mutating func addResults(from newObject: MorePromotionalDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.promotionalList.append(contentsOf: newObject.promotionalList)
        }
    }
    
}
