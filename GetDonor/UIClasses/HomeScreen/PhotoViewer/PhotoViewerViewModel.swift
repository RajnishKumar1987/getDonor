//
//  PhotoViewerViewModel.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class PhotoViewerViewModel {
    let model: PhotoViewerDataModel!
    
    init(with extraDataItem: [ExtraData]) {
        self.model = PhotoViewerDataModel(with: extraDataItem)
    }
    
    init(with photoItem: [Photo]) {
        
        self.model = PhotoViewerDataModel(with: photoItem)
    }
}
