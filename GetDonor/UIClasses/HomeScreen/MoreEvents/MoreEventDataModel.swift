//
//  MoreEventDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct MoreEventDataModel: Codable {
    
    var eventList: [ContentDataModel] = []
    var totalPages: Int? = 0
    var currentPage: Int? = 0
    
    mutating func addResults(from newObject: MoreEventDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.eventList.append(contentsOf: newObject.eventList)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case eventList = "node"
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
}
