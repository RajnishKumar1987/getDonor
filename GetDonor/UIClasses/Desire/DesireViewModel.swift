//
//  DesireViewModel.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation


enum DesireCellType{
    case corousal, vision, objective, mission
}

protocol DesireCellViewModel {
}

struct HeadeAndDescriptionCellViewModel: DesireCellViewModel {
    var headerText: String?
    var descriptionText: String?
    
    init(with headertext:String?, and descTextArray:[String]?) {
        
        self.headerText = headertext
        self.descriptionText = " ● " + (descTextArray?.joined(separator: "\n\n ● "))!
    }
    
    
}
struct CorousalCellViewModel: DesireCellViewModel {
    
    var imagePathArray: [String]?
    
    init(with desireItem: [String]?) {
        
        if let data = desireItem   {
            
            imagePathArray = data
        }
    }
    
}

class DesireViewModel {
    
    var apiLoader: APIRequestLoader<DesireApiRequest>?
    var model: DesireModel?
    var cellType = Array<DesireCellType>()
    
    
    init(with apiLoader: APIRequestLoader<DesireApiRequest> = APIRequestLoader(apiRequest: DesireApiRequest())) {
        
        self.apiLoader = apiLoader
    }
    
    func loadDesire(with result: @escaping(Result<String>)->Void) {
        
        let requestParam = ["version":"1.0.0"]
        
        apiLoader?.loadAPIRequest(requestData: requestParam, completionHandler: { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.model = response
                weakSelf.cellType = weakSelf.getCellType(from: response)
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        })
    }
    
    
    func getModelFor(cell cellType: DesireCellType) -> DesireCellViewModel {
        
        switch cellType {
        case .corousal:
            return CorousalCellViewModel(with: model?.node.corousal)
        case .vision:
            return HeadeAndDescriptionCellViewModel(with: "Our Vision", and: model?.node.vision)
        case .objective:
            return HeadeAndDescriptionCellViewModel(with: "Our Objectives", and: model?.node.objective)
        case .mission:
            return HeadeAndDescriptionCellViewModel(with: "Our Mission", and: model?.node.mission)

        }
        
    }
    
    func getCellType(from model: DesireModel) -> Array<DesireCellType> {
        
        var cellTypeArray = Array<DesireCellType>()
        
        
            let container = model.node
            
            if let corousal = container.corousal, corousal.count > 0  {
                
                cellTypeArray.append(.corousal)
            }
            
            if container.vision != nil{
                cellTypeArray.append(.vision)
            }
            if container.objective != nil{
                cellTypeArray.append(.objective)
            }
            if container.mission != nil{
                cellTypeArray.append(.mission)
            }

        
        
        
        return cellTypeArray
        
    }
    
    
}
