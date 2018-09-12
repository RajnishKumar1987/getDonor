//
//  ProfileViewModel.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    let apiLoader: APIRequestLoader<ProfileApiRequest>!
    var model = ProfileDataModel()
    
    init(loader: APIRequestLoader<ProfileApiRequest> = APIRequestLoader(apiRequest: ProfileApiRequest())) {
        self.apiLoader = loader
    }
    
    
    func userProfile(for userId:String, action: UserProfileActionType, userDetails:[String:String]? = [:], andcompletionHandler result:@escaping(Result<String>)->Void) {
        
        var requestParam : [String:String] = [:]
        requestParam["id"] = userId
        requestParam["action"] = action.rawValue

        if let inputParam = userDetails {
            
             requestParam = requestParam.merging(inputParam) { (current, _) in current }
        }
        
        apiLoader.loadAPIRequest(forFuncion: .updateProfile, requestData: requestParam) {[weak self] (response, error) in
            
            if let response = response {
                if response.message == "successful"{
                    self?.model = response
                    result(.Success)
                }else
                {
                    result(.failure(response.message!))
                }
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
}
