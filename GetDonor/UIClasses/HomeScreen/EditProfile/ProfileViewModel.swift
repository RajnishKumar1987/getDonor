//
//  ProfileViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    let apiLoader: APIRequestLoader<ProfileApiRequest>!
    let updateProfileApiLoader: APIRequestLoader<UpdateProfileApiRequest>!
    
    var model = ProfileDataModel()
    
    init(loader: APIRequestLoader<ProfileApiRequest> = APIRequestLoader(apiRequest: ProfileApiRequest()), updateProfileloader: APIRequestLoader<UpdateProfileApiRequest> = APIRequestLoader(apiRequest: UpdateProfileApiRequest())) {
        self.apiLoader = loader
        self.updateProfileApiLoader = updateProfileloader
    }
    
    func updateUserProfile(for userId: String, action: UserProfileActionType, userDetails:[String: Any], andcompletionHandler result:@escaping(Result<String>)->Void) {
        
        updateProfileApiLoader.loadAPIRequest(forFuncion: .updateProfile(id: userId, action: action), requestData: userDetails) {[weak self] (response, error) in
            
            if let response = response {
                if response.message == "successful"{
                    self?.model = response
                    if let imageURL = response.user?.image{
                        AppConfig.setUserProfileImageUrl(urlString: imageURL)
                    }
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
    
    func getProfile(for userId:String, action: UserProfileActionType, userDetails:[String:String]? = [:], andcompletionHandler result:@escaping(Result<String>)->Void) {
        
        var requestParam : [String:String] = [:]
        requestParam["id"] = userId
        requestParam["action"] = action.rawValue

        if let inputParam = userDetails {
            
             requestParam = requestParam.merging(inputParam) { (current, _) in current }
        }
        
        apiLoader.loadAPIRequest(forFuncion: .getProfile, requestData: requestParam) {[weak self] (response, error) in
            
            if let response = response {
                if response.message == "successful"{
                    self?.model = response
                    
                    if let bloodGroup = response.user?.b_group{
                        AppConfig.setUserBloodGroup(bgroupId: bloodGroup)
                    }
                    if let imageURL = response.user?.image{
                        AppConfig.setUserProfileImageUrl(urlString: imageURL)
                    }
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
