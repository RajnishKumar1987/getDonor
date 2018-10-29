//
//  ArticlesDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct ArticlesDataModel: Codable {
    
    var articleList: [ContentDataModel] = []
    var currentPage: Int?
    var totalPages: Int?
    
    mutating func addResults(from newObject: ArticlesDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.articleList.append(contentsOf: newObject.articleList)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case articleList = "node"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
}
