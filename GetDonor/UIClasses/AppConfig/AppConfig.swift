//
//  AppConfig.swift
//  GetDonor
//
//  Created by admin on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

enum DevelopmentEnvironment {
    case stagging
    case production
}

struct AppConfig {
    
    static let environment: DevelopmentEnvironment = .production
    
    func setUserLoggedIn(status: Bool) {
        
        UserDefaults.standard.set(status, forKey: "userLoginStatus")
        UserDefaults.standard.synchronize()
    }
    
    func getUserLoginStatus() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "userLoginStatus")
        
    }
    
}

