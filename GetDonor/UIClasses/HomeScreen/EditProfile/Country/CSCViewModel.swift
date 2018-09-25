//
//  CSCViewModel.swift
//  GetDonor
//
//  Created by admin on 25/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class CSCViewModel {
    
    var apiLoader: APIRequestLoader<CommonApiRequest>!
    
    init(loader: APIRequestLoader<CommonApiRequest>! = APIRequestLoader(apiRequest: CommonApiRequest())) {
        self.apiLoader = loader
    }
    
    func loadCountryList() {
        
        apiLoader.loadAPIRequest(forFuncion: .getCSCList(listingType: .country, id: ""), requestData: nil) { (response, error) in
            print(response)
        }
    }
    
}
