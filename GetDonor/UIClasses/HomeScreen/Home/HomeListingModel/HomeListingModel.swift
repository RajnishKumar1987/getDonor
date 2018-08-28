//
//  HomeListingModel.swift
//  GetDonor
//
//  Created by admin on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct HomeListingModel: Codable {
    
    var contents: Content?
    
    enum CodingKeys: String, CodingKey {
        case contents = "node"
    }
    
}

struct Content: Codable {
    
    var article: [Article] = []
    var event: [Event] = []
    var video: [Video] = []
    var photo: [Photo] = []
    
}

struct Article: Codable {
    
    var id: String?
    var image: String?
    var title: String?
    var insertdate: String?
    var priority: String?
    var status: String?
    var updatedate: String?
    var description: String?
    var data: String?
    var type: String?
    
}

struct Event: Codable{
    
    var id: String?
    var image: String?
    var title: String?
    var insertdate: String?
    var priority: String?
    var status: String?
    var updatedate: String?
    var description: String?
    var data: String?
    var type: String?
    
}

struct Video: Codable{
    
    var id: String?
    var image: String?
    var title: String?
    var insertdate: String?
    var priority: String?
    var status: String?
    var updatedate: String?
    var description: String?
    var data: String?
    var type: String?
    
}
struct Photo: Codable {
    
    var id: String?
    var image: String?
    var title: String?
    var insertdate: String?
    var priority: String?
    var status: String?
    var updatedate: String?
    var description: String?
    var data: String?
    var type: String?
    
}




