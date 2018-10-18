//
//  DonationDetailsViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 05/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class DonationDetailsViewModel {
    
    var apiLoader: APIRequestLoader<DonationDetailsApiRequest>!
    var myDonation = DonationDetailsDataModel()
    var allDonations = DonationDetailsDataModel()
    
    init(loader:APIRequestLoader<DonationDetailsApiRequest> = APIRequestLoader(apiRequest: DonationDetailsApiRequest()) ) {
        self.apiLoader = loader
    }
    
    func getModelFor(cellType:DonationDetailsType, indexPath: IndexPath) -> Transaction {
        switch cellType {
        case .allDonations:
            return allDonations.transactions[indexPath.row]
        case .myDonation:
            return myDonation.transactions[indexPath.row]
        }
    }
    
    func getCellCountFor(cellType: DonationDetailsType) -> Int {
        switch cellType {
        case .allDonations:
            return allDonations.transactions.count
        case .myDonation:
            return myDonation.transactions.count
        }
    }
    
    func loadDonationDetails(for type: DonationDetailsType, result: @escaping(Result<String>)->Void) {
        
        apiLoader.loadAPIRequest(forFuncion: .getDonationDetails(action: type, userId: AppConfig.getUserId()), requestData: nil) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                switch type{
                case .myDonation:
                    weakSelf.myDonation = response
                case .allDonations:
                    weakSelf.allDonations = response
                }
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
    }
    
}
