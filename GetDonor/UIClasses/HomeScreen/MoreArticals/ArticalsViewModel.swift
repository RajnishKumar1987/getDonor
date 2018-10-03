//
//  ArticalsViewMOdel.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ArticalsViewModel {
    
    let apiLoader: APIRequestLoader<ArticalsApiRequest>!
    var model = ArticalsDataModel()
    var isLoadingNextPageResults: Bool = false
    var isUserRefreshingList: Bool = false

    init(loader: APIRequestLoader<ArticalsApiRequest> = APIRequestLoader(apiRequest: ArticalsApiRequest())) {
        self.apiLoader = loader
    }
    
    func getModelForCell(at indexPath: IndexPath) -> Article {
        
        return model.articalList![indexPath.row]
    }
    
    func loadArticals(with result:@escaping(Result<String>)->Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1

        let requestParam = ["version":Bundle.main.versionNumber,
                            "type":"\(ContentType.artical.rawValue)",
                            "page": "\(page)"]
        
        apiLoader.loadAPIRequest(forFuncion: .getListing, requestData: requestParam) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.model = response
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
}
