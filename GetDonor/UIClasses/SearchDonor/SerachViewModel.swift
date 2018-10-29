//
//  SerachViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 27/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    var apiLoader: APIRequestLoader<SearchApiRequest>!
    var model = SearchDataModel()
    var isLoadingNextPageResults: Bool = false

    init(loader: APIRequestLoader<SearchApiRequest> = APIRequestLoader(apiRequest: SearchApiRequest())) {
        self.apiLoader = loader
    }
    
    func canLoadNextPage() -> Bool {
        
        if isLoadingNextPageResults { return false }
        
        if let currentPage = model.currentPage, let totalPages = model.totalPages, currentPage + 1 > totalPages {
            return false
        }
        
        return true
    }
    
    func serachUser(bloodGroup: String, result:@escaping(Result<String>)->Void) {
        
        let page = model.currentPage! + 1

        apiLoader.loadAPIRequest(forFuncion: .searchDonor(id: GetDonorUserDefault.sharedInstance.getUserId(), bloodGroup: bloodGroup, lat: LocationManager.sharedInstance.latitude, lon: LocationManager.sharedInstance.longitude, page: "\(page)"), requestData: nil) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            if let response = response {
                weakSelf.model.addResults(from: response)
                result(.Success)
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
    }
    
    
}
