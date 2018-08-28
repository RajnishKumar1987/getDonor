//
//  Font+Extra.swift
//  GetDonor
//
//  Created by admin on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

enum TextStyle {
    case headline
    case subHead
    case body
    case title1
    case title2
    case title3
    case caption1
    case caption2
}

extension UIFont{
    
   static func fontWithTextStyle(textStyle: TextStyle) -> UIFont {
        
        switch textStyle {
        case .title1:
            return UIFont(name: "Muli", size: 18.0)!
        case .title2:
            return UIFont(name: "Muli", size: 14.0)!
        case .title3:
            return UIFont(name: "Muli", size: 12.0)!
        case .body:
            return UIFont(name: "Muli", size: 11.0)!
        case .headline:
            return UIFont(name: "Muli-Bold", size: 20.0)!
        case .subHead:
            return UIFont(name: "Muli-Bold", size: 18.0)!
        case .caption1:
            return UIFont(name: "Muli", size: 12.0)!
        case .caption2:
            return UIFont(name: "Muli", size: 10.0)!
        }
    }
}
