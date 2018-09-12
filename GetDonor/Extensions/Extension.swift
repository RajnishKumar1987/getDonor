//
//  Tabbar+Extra.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UIButton {
    func loadingIndicator(show: Bool) {
        let tag = 9876
        if show {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: (buttonWidth/2)+60, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }}


@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UIViewController{
    
    func getTabBarHeight() -> CGFloat {
        
        var tabbarHeight: CGFloat = CGFloat(0.0)
        if #available(iOS 11.0, *) {
            tabbarHeight = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! + 49
        } else {
            tabbarHeight = 49
        }
        
        return tabbarHeight
    }
    
    func addLoaderViewForNextResults() {
        
        
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - (kLoaderViewHeight + getTabBarHeight()) , width: self.view.frame.size.width, height: kLoaderViewHeight))
        view.backgroundColor = UIColor.lightGray
        view.tag = kLoaderViewTag
        
        let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicatorView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        indicatorView.startAnimating()
        indicatorView.color = UIColor.white
        indicatorView.isHidden = false
        view.addSubview(indicatorView)
        
        self.view.addSubview(view)
    }
    
}
