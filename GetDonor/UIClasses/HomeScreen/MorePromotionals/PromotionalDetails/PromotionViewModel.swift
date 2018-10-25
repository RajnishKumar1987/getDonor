//
//  PromotionViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

enum PromotionDetailsCellType {
    case title, image, description, vidoes
}


class PromotionViewModel {
    var apiLoader: APIRequestLoader<PromotionApiRequest>!
    var model = PromotionDatatModel()
    var cellType = [PromotionDetailsCellType]()

    init(loader: APIRequestLoader<PromotionApiRequest>! = APIRequestLoader(apiRequest: PromotionApiRequest())) {
        self.apiLoader = loader
    }
    
    func loadPromotionPage(for contentId: String, result:@escaping(Result<String>)-> Void)  {
        
        apiLoader.loadAPIRequest(forFuncion: .getSpecialPageDetails(id: contentId), requestData: nil) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                if response.message != "successful"{
                    result(.failure(response.message!))
                }
                weakSelf.model = response
                weakSelf.cellType = weakSelf.getCellType(model: response)
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
    func getModelFor(cellType: PromotionDetailsCellType) ->  [ContentDataModel]{
        
        var dataModel = [ContentDataModel]()
        
        switch cellType {
        case .image:
            if let images = model.response?.extraData?.image{
                dataModel =  images.compactMap({ (imageList) -> ContentDataModel? in
                    ContentDataModel(id: imageList.id, image: imageList.image, title: imageList.title, insertdate: "", priority: "", status: "", updatedate: "", description: "", data: nil, type: String(ContentType.photo.rawValue))
                })
                }
            
        case .vidoes:
            if let videos = model.response?.extraData?.video{
                dataModel =  videos.compactMap({ (video) -> ContentDataModel? in
                    ContentDataModel(id: video.id, image: video.image, title: video.title, insertdate: "", priority: "", status: "", updatedate: "", description: "", data: [ExtraData(caption: video.title, title: video.title, playbackUrl: video.videoid, imageUrl: video.image, id:video.id)], type: String(ContentType.video.rawValue))
                })
                }
        default:
            print("Unknown cell type")

            }
            
        return dataModel
    }
    
    
    func getCellType(model: PromotionDatatModel) -> [PromotionDetailsCellType] {
        var cellType = [PromotionDetailsCellType]()
        
        if let _ = model.response?.title {
            cellType.append(.title)
        }
        if let images = model.response?.extraData?.image, images.count > 0 {
            cellType.append(.image)
        }

        if let _ = model.response?.extraData?.text {
            cellType.append(.description)
        }
        if let videos = model.response?.extraData?.video, videos.count > 0 {
            cellType.append(.vidoes)
        }
        return cellType
        
    }
    
}
