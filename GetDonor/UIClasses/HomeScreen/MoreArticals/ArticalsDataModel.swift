//
//  ArticalsDataModel.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct ArticalsDataModel: Codable {
    
    var articalList: [ContentDataModel] = []
    var currentPage: Int?
    var totalPages: Int?
    
    mutating func addResults(from newObject: ArticalsDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.articalList.append(contentsOf: newObject.articalList)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case articalList = "node"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
}
