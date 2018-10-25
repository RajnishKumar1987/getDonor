//
//  HomeListingModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 22/08/18.
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
    
    var article: [ContentDataModel]? = []
    var event: [ContentDataModel]? = []
    var video: [ContentDataModel]? = []
    var photo: [ContentDataModel]? = []
    var topBanner: [ContentDataModel]? = []
    var social: [Social]? 
    
    enum CodingKeys: String, CodingKey {
        case article
        case event
        case video
        case photo
        case topBanner = "special_page"
        case social = "follow_us_on"
    }

}

struct ContentDataModel: Codable{
    
    var id: String?
    var image: String?
    var title: String?
    var insertdate: String?
    var priority: String?
    var status: String?
    var updatedate: String?
    var description: String?
    var data: [ExtraData]? = []
    var type: String?
    
}



struct ExtraData:Codable {
    
    var caption: String?
    var title: String?
    var playbackUrl: String?
    var imageUrl:String?
    var id: String?
    
        enum CodingKeys: String, CodingKey {
        case caption = "cap"
        case title = "title"
        case playbackUrl = "vu"
        case imageUrl = "image"
        case id 
    }
}

struct Social: Codable {
    var image: String?
    var link: String?
    var title: String?
}



//struct Article: Codable {
//    
//    var id: String?
//    var image: String?
//    var title: String?
//    var insertdate: String?
//    var priority: String?
//    var status: String?
//    var updatedate: String?
//    var description: String?
//    //var data: String?
//    var type: String?
//    
//}
//
//struct Event: Codable{
//    
//    var id: String?
//    var image: String?
//    var title: String?
//    var insertdate: String?
//    var priority: String?
//    var status: String?
//    var updatedate: String?
//    var description: String?
//    var data: [ExtraData]? = []
//    var type: String?
//    
//}
//
//struct Video: Codable{
//    
//    var id: String?
//    var image: String?
//    var title: String?
//    var insertdate: String?
//    var priority: String?
//    var status: String?
//    var updatedate: String?
//    var description: String?
//    var data: [ExtraData]? = []
//    var type: String?
//    
//}
//struct Photo: Codable {
//    
//    var id: String?
//    var image: String?
//    var title: String?
//    var insertdate: String?
//    var priority: String?
//    var status: String?
//    var updatedate: String?
//    var description: String?
//    //var data: [extraData]? = []
//    var type: String?
//    
//}
//
//extension Photo: Equatable{
//    
//    static func ==(lhs: Photo, rhs: Photo) -> Bool {
//        return (lhs.id == rhs.id)
//    }
//
//}




