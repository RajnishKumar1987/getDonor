//
//  HomeListingViewModel.swift
//  GetDonor
//
//  Created by admin on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

enum HomeScreenCellType: String {
    case video = "1", artical = "0", photo = "3", event = "2", promotional = "5"
}

class HomeListingViewModel {
    
    let apiLoader: APIRequestLoader<HomeListingRequest>
    var homeApiResponse: HomeListingModel?
    var cellTypes = Array<HomeScreenCellType>()
    
    
    init(with loader: APIRequestLoader<HomeListingRequest> = APIRequestLoader(apiRequest: HomeListingRequest())) {
        self.apiLoader = loader
    }
    
    
    func loadHomeScreen(with result: @escaping(Result<String>)->Void) {
        
        let requestParam = ["version": Bundle.main.versionNumber]
        
        apiLoader.loadAPIRequest(forFuncion: .getHomeData, requestData: requestParam) { [weak self](apiResponse, error) in
            
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = apiResponse{
                
                
                weakSelf.homeApiResponse = response
                weakSelf.cellTypes = weakSelf.getCellType(model: response)
                result(.Success)
                
            }
            else
            {
                result(.failure(error.debugDescription))
            }
            
        }
        
        
    }
    
    func getCellType(model: HomeListingModel) -> Array<HomeScreenCellType> {
        
        var cellTypes = Array<HomeScreenCellType>()
        
        if let topBanner = model.contents?.topBanner, topBanner.count > 0 {
            cellTypes.append(.promotional)
        }
        if let artical = model.contents?.article, artical.count > 0 {
            cellTypes.append(.artical)
        }
        if let photo = model.contents?.photo, photo.count > 0 {
            cellTypes.append(.photo)
        }
        if let event = model.contents?.event, event.count > 0 {
            cellTypes.append(.event)
        }
        if let videos = model.contents?.video, videos.count > 0 {
            cellTypes.append(.video)
        }

        
        return cellTypes
        
    }
}






