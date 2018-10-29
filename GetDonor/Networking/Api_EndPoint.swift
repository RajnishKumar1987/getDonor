//
//  Api_EndPoint.swift
//  GetDonor
//
//  Created by Rajnish kumar on 07/09/18.
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

enum ContentType: String{
    case article = "0"
    case video = "1"
    case event = "2"
    case photo = "3"
    case  promotinal = "5"
}


enum Api_EndPoint {
    case getHomeData
    case getDesire
    case getImage(urlString: String)
    case getListing
    case getSimilar
    case login(userName: String, password: String)
    case registration
    case userProfile(userId: String, action: UserProfileActionType)
    case getPaymentInfo
    case updateProfile(id: String, action: UserProfileActionType)
    case menu
    case updateLocation
    case getCSCList(listingType: CSCListingType, id: String)
    case searchDonor(id: String, bloodGroup: String, lat: String, lon: String, page: String)
    case updateDeviceToken(id: String, token: String)
    case forgotPassword(userEmail: String)
    case getDonationDetails(action: DonationDetailsType, userId: String)
    case getSpecialPageDetails(id: String)
    case getPromotionalList
    case searchContent(type: ContentType, page: String, searchKeyword: String)
    case getDetails(id: String, type: ContentType)
    case versionUpdate(os: String)
    
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
        case .login(let userName, let password):
            return AppBaseURLs.baseUrl.appending("login.php?username=\(userName)&password=\(password)")
        case .registration:
            return AppBaseURLs.baseUrl.appending("registration.php")
        case .userProfile(let userId, let action):
            return AppBaseURLs.baseUrl.appending("update_profile.php?id=\(userId)&action=\(action.rawValue)")
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
        case .getSpecialPageDetails(let id):
            return AppBaseURLs.baseUrl.appending("special_detail.php?id=\(id)")
        case .getPromotionalList:
            return AppBaseURLs.baseUrl.appending("special_list.php?")
        case .searchContent(let type, let page, let searchKeyword):
            return AppBaseURLs.baseUrl.appending("content_search.php?type=\(type.rawValue)&page=\(page)&q=\(searchKeyword)")
        case .getDetails(let id, let type):
            return AppBaseURLs.baseUrl.appending("detail.php?id=\(id)&type=\(type)")
        case .versionUpdate(let os):
            return AppBaseURLs.baseUrl.appending("versionupdate.php?os=\(os)")
        }
    }

}


