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
enum CSCListingType: String{
    case country = "co"
    case state = "st"
    case city = "ci"
}
enum DonationDetailsType: String {
    case myDonation = "myself"
    case allDonations = "peoples"
}

enum Api_EndPoint {
    case getHomeData
    case getDesire
    case getImage(urlString: String)
    case getListing
    case getSimilar
    case login
    case registration
    case getProfile
    case getPaymentInfo
    case updateProfile(id: String, action: UserProfileActionType)
    case menu
    case updateLocation
    case getCSCList(listingType: CSCListingType, id: String)
    case searchDonor(id: String, bloodGroup: String, lat: String, lon: String, page: String)
    case updateDeviceToken(id: String, token: String)
    case forgotPassword(userEmail: String)
    case getDonationDetails(action: DonationDetailsType, userId: String)
    
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
        case .getProfile:
            return AppBaseURLs.baseUrl.appending("update_profile.php")
        case .getPaymentInfo:
            return AppBaseURLs.baseUrl.appending("pay_info.php")
        case .updateProfile(let id, let action):
            return AppBaseURLs.baseUrl.appending("update_profile.php?id=\(id)&action=\(action.rawValue)")
        case .menu:
            return AppBaseURLs.baseUrl.appending("menu.php")
        case .updateLocation:
            return AppBaseURLs.baseUrl.appending("update_location.php")
        case .getCSCList(let action, let id):
            return AppBaseURLs.baseUrl.appending("csc.php?id=\(id)&t=\(action.rawValue)")
        case .searchDonor(let id, let bloodGroup, let lat, let lon, let page):
            return AppBaseURLs.baseUrl.appending("user_search.php?id=\(id)&b_group=\(bloodGroup)&lat=\(lat)&lon=\(lon)&page=\(page)")
        case .updateDeviceToken(let id, let token):
            return AppBaseURLs.baseUrl.appending("update_token.php?id=\(id)&token=\(token)")
        case .forgotPassword(let userEmail):
            return AppBaseURLs.baseUrl.appending("forgot_pass.php?u=\(userEmail)")
        case .getDonationDetails(let action, let userId):
            return AppBaseURLs.baseUrl.appending("pay.php?action=\(action.rawValue)&uid=\(userId)")

        }
    }

}


