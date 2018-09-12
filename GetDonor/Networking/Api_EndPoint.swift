//
//  Api_EndPoint.swift
//  GetDonor
//
//  Created by admin on 07/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

enum UserProfileActionType: String{
    case get = "GET"
    case set = "SET"
}

enum Api_EndPoint {
    case getHomeData
    case getDesire
    case getImage(urlString: String)
    case getListing
    case getSimilar
    case login
    case registration
    case updateProfile
    
    
    var urlString: String{
        switch self {
        case .getHomeData:
            return AppBaseURLs.baseUrl.appending("home.php")
        case .getDesire:
            return AppBaseURLs.baseUrl.appending("desire.php")
        case .getListing:
            return AppBaseURLs.baseUrl.appending("view_more.php")
        case .getImage(let imageUrl):
            return imageUrl
        case .getSimilar:
            return AppBaseURLs.baseUrl.appending("similar.php")
        case .login:
            return AppBaseURLs.baseUrl.appending("login.php")
        case .registration:
            return AppBaseURLs.baseUrl.appending("registration.php")
        case .updateProfile:
            return AppBaseURLs.baseUrl.appending("update_profile.php")

        }
    }

}


