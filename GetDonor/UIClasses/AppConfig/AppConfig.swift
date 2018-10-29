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

let kAppId =  "id1421647128"    //"id1421647128"//Hungama: id414009038

let appDelegate = UIApplication.shared.delegate as! AppDelegate


enum DevelopmentEnvironment {
    case stagging
    case production
}

struct AppConfig {
    
    static let environment: DevelopmentEnvironment = .production
    
}

