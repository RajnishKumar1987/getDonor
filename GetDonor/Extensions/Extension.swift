//
//  Tabbar+Extra.swift
//  GetDonor
//
//  Created by Rajnish kumar on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit
import Reachability

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
    
    func getBloodGroupId() -> String {
        return bloodGroups[self]!
    }
    func getBloodGroup() -> String {
        return bloodGroups.someKey(forValue: self)!
    }
}

extension UIButton {
    func loadingIndicator(show: Bool, isCenter: Bool = false) {
        let tag = 9876
        if show {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            if isCenter{
                indicator.center = CGPoint(x: (buttonWidth/2), y: buttonHeight/2)
            }
            else{
                indicator.center = CGPoint(x: (buttonWidth/2)+60, y: buttonHeight/2)
            }
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
            self.isUserInteractionEnabled = false
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                self.isUserInteractionEnabled = true
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
    
    func showLoader(onViewController:UIViewController, transparent:Bool = false){
        if let keyWindow = onViewController.view{
            if keyWindow.subviews.count > 1{
                
                let loader = keyWindow.subviews[1]
                
                if (loader.isKind(of: LoaderView.self)){
                    return
                }
            }
            let overlay = Bundle.main.loadNibNamed("LoaderView", owner: nil, options: nil)![0] as! LoaderView
            overlay.frame = onViewController.view.bounds
            keyWindow.addSubview(overlay)
            
        }
    }
    
    func removeLoader(fromViewController:UIViewController){
        let keyWindow = fromViewController.view
        if let _ = keyWindow,(keyWindow?.subviews.count)! > 1{
            keyWindow?.subviews.forEach({ (loader) in
                if (loader.isKind(of: LoaderView.self)){
                    let overlay = loader as! LoaderView
                    overlay.removeFromSuperview()
                }
            })
        }else{
            print("")
        }
    }
    
    func showLoaderOnView(someView: UIView) {
        if let keyWindow = view{
            if keyWindow.subviews.count > 1{
                
                let loader = keyWindow.subviews[1]
                
                if (loader.isKind(of: LoaderView.self)){
                    return
                }
            }
            let overlay = Bundle.main.loadNibNamed("LoaderView", owner: nil, options: nil)![0] as! LoaderView
            overlay.frame = someView.bounds
            keyWindow.addSubview(overlay)
            
        }
    }
    
    func showAlert(with title:String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkInternetStatus(viewController : UIViewController, navigationBarPresent : Bool) -> Bool {
        
        let reachability = Reachability.init()!
        switch reachability.connection {
        case .cellular:
            print("Reachable")
            removeNoInternetView(viewController: viewController)
            return true
        case .wifi:
            print("Reachable")
            removeNoInternetView(viewController: viewController)
            return true
        case .none:
            print("Not reachable")
            showNoInternetView(viewController: viewController, navigationBarPresent: navigationBarPresent)
            return false
        }
    }
    
    func showNoInternetView(viewController : UIViewController, navigationBarPresent : Bool) {
        
        var tabbarHeight        :CGFloat  = 0.0
        var navigationbarHeight :CGFloat  = viewController.navigationController?.navigationBar.frame.size.height ?? 0
        
        if viewController.tabBarController != nil {
            tabbarHeight = getTabBarHeight()
        }
        
        if !navigationBarPresent {
            navigationbarHeight = 0
        }else{
            navigationbarHeight = navigationbarHeight + 20
        }
        
        /* Used for excluding tab bar height and navigation item height. */
        let upAndDownSpace:CGFloat = tabbarHeight + navigationbarHeight
        
        var screenRect = UIScreen.main.bounds
        if let baseView = viewController as? BaseViewController {
            if let tableview = baseView.view{
                screenRect = tableview.bounds

            }

        }
        
        let noInternetoverlay = Bundle.main.loadNibNamed("NoInternetView", owner: nil, options: nil)![0] as? NoInternetView
        
        
        noInternetoverlay?.frame = CGRect(x: 0, y: navigationbarHeight, width: screenRect.size.width, height: screenRect.size.height - upAndDownSpace)
        noInternetoverlay?.targetVc = viewController
        noInternetoverlay?.alpha = 0
        
        if let baseViewController = viewController as? BaseViewController{
            noInternetoverlay?.backgroundColor = baseViewController.view.backgroundColor
            
            //            if let tableview = baseViewController.tableview{
            //                tableview.addSubview(noInternetoverlay!)
            //                baseViewController.isNoInternetPresented = true
            //            }else if let collectionView = baseViewController.collectionview{
            //                collectionView.addSubview(noInternetoverlay!)
            //                baseViewController.isNoInternetPresented = true
            //            }else{
            //                viewController.view.addSubview(noInternetoverlay!)
            //            }
            viewController.view.addSubview(noInternetoverlay!)
            
        }else{
            viewController.view.addSubview(noInternetoverlay!)
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {
            noInternetoverlay?.alpha = 1
        })
        
        
    }
    
    func removeNoInternetView(viewController : UIViewController) {
        
        
        var keyWindow:UIView?
        
        //        if let baseViewController = viewController as? BaseViewController{
        //            if let tableview = baseViewController.tableview{
        //                keyWindow = tableview
        //            }else if let collectionView = baseViewController.collectionview{
        //                keyWindow = collectionView
        //            }else{
        //                keyWindow = viewController.view
        //            }
        //            baseViewController.isNoInternetPresented = false
        //        }else{
        //            keyWindow = viewController.view
        //        }
        
        keyWindow = viewController.view
        
        
        if let _ = keyWindow,(keyWindow?.subviews.count)! > 1{
            
            keyWindow?.subviews.forEach({ (loader) in
                if (loader.isKind(of: NoInternetView.self)){
                    
                    let overlay = loader as! NoInternetView
                    UIView.animate(withDuration: 0.3, animations: {
                        overlay.alpha = 0
                    }, completion: { (done) in
                        //SharedManager.shared.isNoNetworkViewPresented = false
                        overlay.removeFromSuperview()
                    })
                }
            })
            
            
        }else{
            print("")
        }
        
    }
    
    
    
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String, with font: UIFont) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: font]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

extension Data {
    
    /// Append string to Data
    ///
    /// Rather than littering my code with calls to `data(using: .utf8)` to convert `String` values to `Data`, this wraps it in a nice convenient little extension to Data. This defaults to converting using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `Data`.
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

extension Date {
    
    func getDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
    
    
}

extension UIViewController{
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyBoard() {
        self.view.endEditing(true)
    }
}

extension URL{
    
    func getMD5WithSceretKey() -> String {
        
        let urlComp = URLComponents(string: self.absoluteString)
        
        var md5String = AppBaseURLs.apiSecretKey.utf8.md5.description
        
        if let queryItem = urlComp?.queryItems {
            let result = queryItem.map { (item) -> String in
                return item.value!
                }.joined(separator: "")
            
            md5String = (AppBaseURLs.apiSecretKey + result).utf8.md5.description
            
        }
        
        return md5String
        
    }
}

extension UIImageView{
    func loadImage(from urlString: String?, shouldCache: Bool) {
        guard let url = urlString else { return }
        
        let imageLoader = APIRequestLoader(apiRequest: ImageRequest(shouldCache: shouldCache))
        imageLoader.loadAPIRequest(forFuncion: .getImage(urlString: url), requestData: nil) { (image, error) in
            
            if let image = image{
                self.image = image
            }
        }
        
    }
}
extension UIView{
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

public extension UISearchBar {
    
    public func setNewcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}
extension UITableView{
    func addBgViewWith(message: String?) {
        let bgView = UILabel(frame: self.frame)
        bgView.textAlignment = .center
        bgView.numberOfLines = 20
        bgView.font = UIFont.fontWithTextStyle(textStyle: .title1)
        bgView.text = message
        self.backgroundView = bgView
    }
}

extension String {
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSMutableAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}



