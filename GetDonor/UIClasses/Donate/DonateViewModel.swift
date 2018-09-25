//
//  DonateViewModel.swift
//  GetDonor
//
//  Created by admin on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

enum DonateCellType{
    case description
    case qa(index: Int)
    case secure
    case upiDetails
    case bankDetails
    case cashDetails
}

protocol DonateTableViewCellModel {

}
struct DonateDescriptionCellViewModel: DonateTableViewCellModel {
    var info: String?
    
    init(with donateDataItem: DonateDataModel) {
        self.info = donateDataItem.response?.description?.info ?? ""
    }
}
struct DonateScureCellViewModel: DonateTableViewCellModel {
    var info: String?

    init(with donateDataItem: DonateDataModel) {
        self.info = donateDataItem.response?.security?.info ?? ""
    }
}
struct DonateUPIDetailsCellViewModel: DonateTableViewCellModel {
    var info: String?
    
    init(with donateDataItem: DonateDataModel) {
        self.info = donateDataItem.response?.upiDetails?.info ?? ""
    }
}

struct DonateCashDetailsCellViewModel: DonateTableViewCellModel {
    var info: String?
    
    init(with donateDataItem: DonateDataModel) {
        self.info = donateDataItem.response?.cashDetails?.info ?? ""
    }
}


struct DonateQandACellViewModel: DonateTableViewCellModel {
    var question: String?
    var answer: String?
    
    init(with QandAItem: QandA) {
        self.question = QandAItem.question ?? ""
        self.answer = QandAItem.answer
    }
}

struct DonateBankDetailsCellViewModel: DonateTableViewCellModel {
    var info: String?
    var accountName: String?
    var bankName: String?
    var accountNumber: String?
    var ifscCode: String?

    init(with bankDataItem: BankDetails) {
        self.info = bankDataItem.info ?? ""
        self.accountName = bankDataItem.accountName ?? ""
        self.bankName = bankDataItem.bankName ?? ""
        self.accountNumber = bankDataItem.accountNumber ?? ""
        self.ifscCode = bankDataItem.ifscCode ?? ""
        self.info = bankDataItem.info ?? ""
    }
    
    
}



class DonateViewModel {
    var apiLoader: APIRequestLoader<DonateApiRequest>?
    var model: DonateDataModel?
    var cellTypes = Array<DonateCellType>()
    
    init(with apiLoader: APIRequestLoader<DonateApiRequest> = APIRequestLoader(apiRequest: DonateApiRequest())) {
        
        self.apiLoader = apiLoader
    }
    
    func loadDonationDetails(with result:@escaping(Result<String>)->Void) {
        
        let requestParam = ["version":Bundle.main.versionNumber]
        
        apiLoader?.loadAPIRequest(forFuncion: .getDonationDetails, requestData: requestParam) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.model = response
                weakSelf.cellTypes = weakSelf.getCellType(from: response)

                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
    }
    
    func getModelFor(cell cellType: DonateCellType) -> DonateTableViewCellModel {
        
        switch cellType {
        case .description:
            return DonateDescriptionCellViewModel(with: model!)
        case .qa(let Index):
            return DonateQandACellViewModel(with: (model?.response?.qa![Index])!)
        case .secure:
            return DonateScureCellViewModel(with: model!)
        case .upiDetails:
            return DonateUPIDetailsCellViewModel(with: model!)
        case .bankDetails:
            return DonateBankDetailsCellViewModel(with: (model?.response?.bankDetails)!)
        case .cashDetails:
            return DonateCashDetailsCellViewModel(with: model!)

        }
        
    }

    func getCellType(from model: DonateDataModel) -> Array<DonateCellType> {
        
        var cellTypeArray = Array<DonateCellType>()
        
        
        let container = model.response
        
        if let _ = container?.description?.info  {
            cellTypeArray.append(.description)
        }
        
        if let qa = container?.qa, qa.count > 0 {
            
            for i in 0...qa.count - 1
            {
                cellTypeArray.append(.qa(index: i))
                
            }
        }
        
        if let _ = container?.security?.info  {
            cellTypeArray.append(.secure)
        }
        if let _ = container?.upiDetails?.info  {
            cellTypeArray.append(.upiDetails)
        }
        if let _ = container?.bankDetails  {
            cellTypeArray.append(.bankDetails)
        }
        if let _ = container?.cashDetails?.info  {
            cellTypeArray.append(.cashDetails)
        }
        
        return cellTypeArray
        
    }

}


