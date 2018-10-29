//
//  ArticleDetailsViewModel.swift
//  GetDonor
//
//  Created by admin on 25/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ArticleDetailsViewModel {
    
    let apiLoader: APIRequestLoader<ArticleDetailsApiRequest>!
    var model = ArticleDetailsDataModel()

    init(loader: APIRequestLoader<ArticleDetailsApiRequest> = APIRequestLoader(apiRequest: ArticleDetailsApiRequest())) {
        self.apiLoader = loader
    }
    
    func loadArticleDetails(contentId: String, result:@escaping(Result<String>)->Void) {
        
        apiLoader.loadAPIRequest(forFuncion: .getDetails(id: contentId, type: .article), requestData: nil) { [weak self](response, error) in
            
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
