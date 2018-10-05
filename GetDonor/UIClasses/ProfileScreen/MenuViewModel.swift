//
//  MenuViewModel.swift
//  GetDonor
//
//  Created by admin on 21/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class MenuViewModel {
    
    var apiLoader: APIRequestLoader<MenuApiRequest>!
    var model = MenuDataModel()
    
    init(loader: APIRequestLoader<MenuApiRequest> = APIRequestLoader(apiRequest: MenuApiRequest())) {
        self.apiLoader = loader
    }
    
    func loadMenu(with result: @escaping(Result<String>)-> Void) {
        
         let requestParam = ["version":Bundle.main.versionNumber]
        apiLoader.loadAPIRequest(forFuncion: .menu, requestData: requestParam) { [weak self](response, error) in
            
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
