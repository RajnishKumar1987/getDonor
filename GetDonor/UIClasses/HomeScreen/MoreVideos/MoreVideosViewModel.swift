//
//  MoreVideosViewModel.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class MoreVideosViewModel {
    
    let apiLoader: APIRequestLoader<MoreVideosApiRequest>!
    var model = MoreVideosDataModel()
    var isLoadingNextPageResults: Bool = false
    var isUserRefreshingList: Bool = false

    init(loader: APIRequestLoader<MoreVideosApiRequest> = APIRequestLoader(apiRequest: MoreVideosApiRequest())) {
        self.apiLoader = loader
    }
    
    func getModelForCell(at indexPath: IndexPath) -> Video {
        
        return model.vidoeList[indexPath.row]
    }
    
    func canLoadNextPage() -> Bool {
        
        if isLoadingNextPageResults || isUserRefreshingList { return false }
        
        if let currentPage = model.currentPage, let totalPages = model.totalPages, currentPage + 1 > totalPages {
            return false
        }
        
        return true
    }
    
    func loadMoreVideos(with result:@escaping(Result<String>)->Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1

        let requestParam = ["version":Bundle.main.versionNumber,
                            "type":"\(ContentType.video.rawValue)",
                            "page":"\(page)"]

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
