//
//  SearchDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 27/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct SearchDataModel: Codable {
    var message: String?
    var totalPages: Int? = 0
    var currentPage: Int? = 0
    var donors: [Doner] = []
    
    mutating func addResults(from newObject: SearchDataModel) {
        
        if let newPage = newObject.currentPage {
            
            self.currentPage = newPage
            self.totalPages = newObject.totalPages
            self.donors.append(contentsOf: newObject.donors)
        }
    }

    enum CodingKeys: String, CodingKey {
        case message
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case donors = "node"
    }
    
}

struct Doner: Codable{
    var phone: String?
    var firstname: String?
    var lastname: String?
    var dob: String?
    var address: String?
    var city: String?
    var country: String?
    var b_group: String?
    var image: String?
}
