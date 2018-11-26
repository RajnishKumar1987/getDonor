//
//  CSCViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 25/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class CSCViewModel {
    
    var apiLoader: APIRequestLoader<CommonApiRequest>!
    var countryName = [String]()
    var stateName = [String]()
    var cityName = [String]()
    var selectedState = ""
    var selectedCity = ""
    var selectedCountry = ""
    var dataToPopulate = Array<String>()
    
    
    
    
    init(loader: APIRequestLoader<CommonApiRequest>! = APIRequestLoader(apiRequest: CommonApiRequest())) {
        self.apiLoader = loader
    }
    
    func loadCSCList(with cscType: CSCListingType, and id: String, result: @escaping (Result<String>)->Void) {
        
        
        apiLoader.loadAPIRequest(forFuncion: .getCSCList(listingType: cscType, id: id), requestData: nil) { [weak self](response, error) in
            
            if let responseDict = response, let dict = responseDict["node"] as? Array<String>{
                
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
//        switch cscType {
//        case .city:
//            return selectedState == name ? false : true
//        case .state:
//            return (stateName.someKey(forValue: name) != nil) ? false : true
//            //return selectedCountry == name ? false : true
//        case .country:
//            dataToPopulate = countryName
//            return countryName.count>0 ? false : true
//
//        }
    }
    
    
    

    
}
