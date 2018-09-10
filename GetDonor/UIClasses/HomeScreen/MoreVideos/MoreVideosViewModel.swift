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
    
    init(loader: APIRequestLoader<MoreVideosApiRequest> = APIRequestLoader(apiRequest: MoreVideosApiRequest())) {
        self.apiLoader = loader
    }
    
    func getModelForCell(at indexPath: IndexPath) -> Video {
        
        return model.vidoeList![indexPath.row]
    }
    
    func loadMoreVideos(with result:@escaping(Result<String>)->Void) {
        
        let requestParam = ["version":Bundle.main.versionNumber,
                            "type":"\(ContentType.video.rawValue)"]

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
