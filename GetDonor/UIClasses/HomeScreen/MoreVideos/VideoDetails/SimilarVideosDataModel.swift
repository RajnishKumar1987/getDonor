//
//  SimilarVideosDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct SimilarVideosDataModel:Codable {
    
    var vidoeList: [ContentDataModel] = []
    var totalPages: Int? = 0
    var currentPage: Int? = 0
    
    mutating func addResults(from newObject: SimilarVideosDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.vidoeList.append(contentsOf: newObject.vidoeList)
        }
    }

    
    enum CodingKeys: String,CodingKey {
        case vidoeList = "node"
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
    
    
}
