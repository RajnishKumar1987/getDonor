//
//  AppBaseURLs.swift
//  GetDonor
//
//  Created by Rajnish kumar on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct AppBaseURLs {
        
    static let baseUrl: String = {
        switch AppConfig.environment {
        case .production:
            return "http://www.getdonor.org/mapi/"
        case .stagging:
            return "http://www.getdonor.org/mapi/"
        }    }()
    
    static let apiSecretKey: String = {
       
        switch AppConfig.environment {
        case .production:
            return "#gEtB0n0r!@#321"
        case .stagging:
            return "#gEtB0n0r!@#321"
        }
    }()
    
}
