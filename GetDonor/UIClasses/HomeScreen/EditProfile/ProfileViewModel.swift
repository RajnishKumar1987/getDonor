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
                        GetDonorUserDefault.sharedInstance.setUserProfileImageUrl(urlString: imageURL)
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
    
    func getProfile(for userId:String, action: UserProfileActionType, andcompletionHandler result:@escaping(Result<String>)->Void) {
        
        
        apiLoader.loadAPIRequest(forFuncion: .userProfile(userId: userId, action: action), requestData: nil) {[weak self] (response, error) in
            
            if let response = response {
                if response.message == "successful"{
                    self?.model = response
                    
                    if let bloodGroup = response.user?.b_group{
                        GetDonorUserDefault.sharedInstance.setUserBloodGroup(bgroupId: bloodGroup)
                    }
                    if let imageURL = response.user?.image{
                        GetDonorUserDefault.sharedInstance.setUserProfileImageUrl(urlString: imageURL)
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
