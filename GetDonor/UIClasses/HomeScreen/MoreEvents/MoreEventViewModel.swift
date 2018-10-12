//
//  MoreEventViewModel.swift
//  GetDonor
//
//  Created by admin on 10/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class MoreEventViewModel {
    
    let apiLoader: APIRequestLoader<MoreEventApiRequest>!
    var model = MoreEventDataModel()
    var isLoadingNextPageResults: Bool = false
    var isUserRefreshingList: Bool = false
    
    init(loader: APIRequestLoader<MoreEventApiRequest> = APIRequestLoader(apiRequest: MoreEventApiRequest())) {
        self.apiLoader = loader
    }
    
    func getModelForCell(at indexPath: IndexPath) -> ContentDataModel {
        
        return model.eventList[indexPath.row]
    }
    
    func canLoadNextPage() -> Bool {
        
        if isLoadingNextPageResults || isUserRefreshingList { return false }
        
        if let currentPage = model.currentPage, let totalPages = model.totalPages, currentPage + 1 > totalPages {
            return false
        }
        
        return true
    }
    
    func loadMoreEvents(with result:@escaping(Result<String>)->Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1
        
        let requestParam = ["version":Bundle.main.versionNumber,
                            "type":"\(ContentType.event.rawValue)",
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
