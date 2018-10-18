//
//  PhotoViewerDataModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct PhotoViewerDataModel {
    var images : [String]
    
    init(with extraDataIteam: [ExtraData]) {
        self.images = extraDataIteam.map({ (iteam) -> String in
            return iteam.imageUrl ?? ""
        })
    }
    
    init(with photoIteam: [ContentDataModel]) {
        
        self.images = photoIteam.map({ (item) -> String in
            return item.image ?? ""
        })
    }
    
}
