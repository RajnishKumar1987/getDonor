//
//  GetDonorUserDefault.swift
//  GetDonor
//
//  Created by admin on 29/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class GetDonorUserDefault {
    
    static let sharedInstance = GetDonorUserDefault()
    
     func setUserLoggedIn(status: Bool) {
        UserDefaults.standard.set(status, forKey: "userLoginStatus")
        UserDefaults.standard.synchronize()
        
        print("setUserLoggedIn: \(getUserLoginStatus())")
    }
    
     func getUserLoginStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "userLoginStatus")
    }
    
     func setUserId(id: String) {
        UserDefaults.standard.set(id, forKey: "userId")
        UserDefaults.standard.synchronize()
    }
     func getUserId() -> String {
        return UserDefaults.standard.string(forKey: "userId") ?? ""
    }
    
     func setUserBloodGroup(bgroupId: String){
        UserDefaults.standard.set(bgroupId, forKey: "userBloodGroup")
        UserDefaults.standard.synchronize()
    }
    
     func getUserBloodGroup()-> String{
        return UserDefaults.standard.string(forKey: "userBloodGroup") ?? ""
        
    }
    
     func setUserProfileImageUrl(urlString: String) {
        UserDefaults.standard.set(urlString, forKey: "userProfileImageUrl")
        UserDefaults.standard.synchronize()
    }
     func getUserProfileImageUrl() -> String? {
        return UserDefaults.standard.string(forKey: "userProfileImageUrl") ?? nil
    }
    
     func setUpdatePopUpFrequency(value: Int) {
        UserDefaults.standard.set(value, forKey: "popUpFreq")
        UserDefaults.standard.synchronize()
    }
     func getUpdatePopUpFrequency() -> Int {
        return UserDefaults.standard.integer(forKey: "popUpFreq")
    }
    
     func increasePopUpFrequency(){
        let freq = UserDefaults.standard.integer(forKey: "popUpFreq")
        UserDefaults.standard.set(freq + 1, forKey: "popUpFreq")
        UserDefaults.standard.synchronize()
        
    }
     func saveVersionUpdatePopUpDate(){
        UserDefaults.standard.set(Date(timeIntervalSinceNow: 0), forKey: "currentDate")
        UserDefaults.standard.synchronize()
    }
    
     func getVersionUpdatePopUpDate() -> Date?
    {
        return UserDefaults.standard.object(forKey: "currentDate") as? Date
        
    }

}
