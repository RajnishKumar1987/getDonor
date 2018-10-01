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
    var countryName = [String: String]()
    var stateName = [String: String]()
    var cityName = [String: String]()
    var selectedState = ""
    var selectedCity = ""
    var selectedCountry = ""
    var dataToPopulate = Dictionary<String,String>()
    
    
    
    
    init(loader: APIRequestLoader<CommonApiRequest>! = APIRequestLoader(apiRequest: CommonApiRequest())) {
        self.apiLoader = loader
    }
    
    func loadCSCList(with cscType: CSCListingType, and id: String, result: @escaping (Result<String>)->Void) {
        
        
        apiLoader.loadAPIRequest(forFuncion: .getCSCList(listingType: cscType, id: id), requestData: nil) { [weak self](response, error) in
            
            if let responseDict = response, let dict = responseDict["node"] as? Dictionary<String, String>{
                
                switch cscType{
                case .country:
                        self?.countryName = dict
                case .state:
                        self?.stateName = dict
                case .city:
                        self?.cityName = dict
                }
                
                self?.dataToPopulate = dict
                result(.Success)
            }
            else{
                result(.failure(error.debugDescription))
            }
            

        }
    }
    
    
    
    func shouldMakeCallToFetchCSCListing(for cscType:CSCListingType, and name:String) -> Bool {
        return true
        switch cscType {
        case .city:
            return selectedState == name ? false : true
        case .state:
            return selectedCountry == name ? false : true
        case .country:
            dataToPopulate = countryName
            return countryName.count>0 ? false : true

        }
    }
    
    
    

    
}
