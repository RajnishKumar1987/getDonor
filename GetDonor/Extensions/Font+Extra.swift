//
//  Font+Extra.swift
//  GetDonor
//
//  Created by Rajnish kumar on 23/08/18.
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
    case extraBold
    case regular
    case title2_bold
    case title1_bold

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
            return UIFont(name: "Muli-Bold", size: 16.0)!
        case .caption1:
            return UIFont(name: "Muli", size: 12.0)!
        case .caption2:
            return UIFont(name: "Muli", size: 10.0)!
        case .extraBold:
            return UIFont(name: "Muli-Bold", size: 30.0)!
        case .regular:
            return UIFont(name: "Muli", size: 16.0)!
        case .title2_bold:
            return UIFont(name: "Muli-Bold", size: 14.0)!
        case .title1_bold:
            return UIFont(name: "Muli-Bold", size: 18.0)!

        }
    }
}

enum UIComponent {
    case tabBar
    case navigationBar
    case button
}

extension UIColor{
    
   static func colorFor(component: UIComponent) -> UIColor {
        
        switch component {
        case .button:
            return hexStringToUIColor(hex: "#b90119")
        case .navigationBar:
            return hexStringToUIColor(hex: "#b90119")
        case .tabBar:
            return hexStringToUIColor(hex: "#b90119")
        }
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


}

