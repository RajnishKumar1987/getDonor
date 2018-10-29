//
//  DesireViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation


enum DesireCellType{
    case corousal
    case headingAndDescription(indexPath: IndexPath)
}

protocol DesireCellViewModel {
}


struct HeadeAndDescriptionCellViewModel: DesireCellViewModel {
    var headerText: String?
    var descriptionText: String?
    
    init(with bodyIteam: BodyText?) {
        
        if let model = bodyIteam {
            
            self.headerText = model.headerText ?? ""
            self.descriptionText = " ● " + (model.descriptiontext?.joined(separator: "\n\n ● "))!

        }
    }
    
    
}
struct CorousalCellViewModel: DesireCellViewModel {
    
    var imagePathArray: [ContentDataModel]?
    
    init(with desireItem: [ContentDataModel]?) {
        
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
        
        apiLoader?.loadAPIRequest(forFuncion: .getDesire, requestData: nil, completionHandler: { [weak self](response, error) in
            
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
            return CorousalCellViewModel(with: model?.response.corousal)
        case .headingAndDescription(let indexPath):
            return HeadeAndDescriptionCellViewModel(with: model?.response.textBody![indexPath.row])
        }
        
    }
    
    func getCarsouelCellModel() -> [ContentDataModel] {
        
        var contentModels = [ContentDataModel]()
        
        if let carousel = model?.response.corousal {
            contentModels = carousel.compactMap({ (model) -> ContentDataModel in
                ContentDataModel(id: model.id, image: model.image, title: model.title, insertdate: "", priority: "", status: "", updatedate: "", description: "", data: nil, type: ContentType.photo.rawValue, s_url: "")
            })
            
        }
        return contentModels
    }
    
    func getCellType(from model: DesireModel) -> Array<DesireCellType> {
        
        var cellTypeArray = Array<DesireCellType>()
        
        
            let container = model.response
            
            if let corousal = container.corousal, corousal.count > 0  {
                
                cellTypeArray.append(.corousal)
            }
        
        if let body = container.textBody, body.count > 0 {
            
            for i in 0...body.count - 1
            {
                cellTypeArray.append(.headingAndDescription(indexPath: IndexPath(row: i, section: 0)))

            }
        }
        
        
        return cellTypeArray
        
    }
    
    
}
