//
//  SimilarVideosViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class SimilarVideosViewModel {
    
    let apiLoader: APIRequestLoader<SimilarVideosApiRequest>!
    var model = SimilarVideosDataModel()
    var isLoadingNextPageResults: Bool = false
    var isUserRefreshingList: Bool = false

    init(loader: APIRequestLoader<SimilarVideosApiRequest> = APIRequestLoader(apiRequest: SimilarVideosApiRequest())) {
        self.apiLoader = loader
    }
    
    func canLoadNextPage() -> Bool {
        
        if isLoadingNextPageResults || isUserRefreshingList { return false }
        
        if let currentPage = model.currentPage, let totalPages = model.totalPages, currentPage + 1 > totalPages {
            return false
        }
        
        return true
    }
    
    func getModelForCell(at indexPath: IndexPath) -> ContentDataModel {
        
        return model.vidoeList[indexPath.row]
    }
    
    func loadSimilarVideos(by contentId:String, with result:@escaping(Result<String>)->Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1

        let requestParam = [
                            "type":"\(ContentType.video.rawValue)",
                            "id":contentId,
                            "page":"\(page)"
                           ]
        
        apiLoader.loadAPIRequest(forFuncion: .getSimilar, requestData: requestParam) { [weak self](response, error) in
            
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
