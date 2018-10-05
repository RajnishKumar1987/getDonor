//
//  MoreVideosDataModel.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct MoreVideosDataModel: Codable {
    
    var vidoeList: [Video] = []
    var currentPage: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case vidoeList = "node"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
    mutating func addResults(from newObject: MoreVideosDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.vidoeList.append(contentsOf: newObject.vidoeList)
        }
    }
    
}

