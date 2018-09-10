//
//  MorePhotosViewModel.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class MorePhotosViewModel {
    
    let apiLoader: APIRequestLoader<MorePhotosApiRequest>!
    var model = MorePhotosDataModel()
    var isLoadingNextPageResults: Bool = false
    var isUserRefreshingList: Bool = false

    init(loader: APIRequestLoader<MorePhotosApiRequest> = APIRequestLoader(apiRequest: MorePhotosApiRequest())) {
        self.apiLoader = loader
    }
    
    func getModelForCell(at indexPath: IndexPath) -> Photo {
        
        return model.photoList[indexPath.row]
    }
    
    func canLoadNextPage() -> Bool {
        
        if isLoadingNextPageResults || isUserRefreshingList { return false }
        
        if let currentPage = model.currentPage, let totalPages = model.totalPages, currentPage + 1 > totalPages {
            return false
        }
        
        return true
    }
    
    func loadMorePhotos(with result:@escaping(Result<String>)->Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1

        let requestParam = ["version":Bundle.main.versionNumber,
                            "type":"\(ContentType.photo.rawValue)",
                            "page":"\(page)"
                           ]
        
        apiLoader.loadAPIRequest(forFuncion: .getListing, requestData: requestParam) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.isUserRefreshingList ? weakSelf.model = response :
                weakSelf.model.addResults(from: response)
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
}