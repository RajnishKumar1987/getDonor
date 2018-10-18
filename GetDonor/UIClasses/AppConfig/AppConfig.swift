//
//  AppConfig.swift
//  GetDonor
//
//  Created by Rajnish kumar on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

let bloodGroupsArray = ["O+","O-","A+","A-","B+","B-","AB+","AB-"]

let bloodGroups = ["O+":"1","O-":"2","A+":"3","A-":"4","B+":"5","B-":"6","AB+":"7","AB-":"8"]

let kCarouselHeight: CGFloat = ((UIScreen.main.bounds.size.width) * 9/16) + 36

let kAppId = "id1421647128"//id1421647128


enum DevelopmentEnvironment {
    case stagging
    case production
}

struct AppConfig {
    
    static let environment: DevelopmentEnvironment = .production
    
    static func setUserLoggedIn(status: Bool) {
        UserDefaults.standard.set(status, forKey: "userLoginStatus")
        UserDefaults.standard.synchronize()
    }
    
    static func getUserLoginStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "userLoginStatus")
    }
    
    static func setUserId(id: String) {
        UserDefaults.standard.set(id, forKey: "userId")
        UserDefaults.standard.synchronize()
    }
    static func getUserId() -> String {
        return UserDefaults.standard.string(forKey: "userId") ?? ""
    }
    
    static func setUserBloodGroup(bgroupId: String){
        UserDefaults.standard.set(bgroupId, forKey: "userBloodGroup")
        UserDefaults.standard.synchronize()
    }
    
    static func getUserBloodGroup()-> String{
        return UserDefaults.standard.string(forKey: "userBloodGroup") ?? ""

    }

    
}

