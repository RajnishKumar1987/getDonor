//
//  Font+Extra.swift
//  GetDonor
//
//  Created by admin on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

enum GetDonerTextStyle {
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
    
    static func fontWithTextStyle(textStyle: GetDonerTextStyle) -> UIFont {
        
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
            return UIColor.red
        case .navigationBar:
            return UIColor.red
        case .tabBar:
            return UIColor.red
        }
    }
}

