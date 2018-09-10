//
//  MorePhotosDataModel.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct MorePhotosDataModel: Codable {
    
    var photoList: [Photo] = []
    var totalPages: Int? = 0
    var currentPage: Int? = 0
    
    mutating func addResults(from newObject: MorePhotosDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.photoList.append(contentsOf: newObject.photoList)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case photoList = "node"
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
}
