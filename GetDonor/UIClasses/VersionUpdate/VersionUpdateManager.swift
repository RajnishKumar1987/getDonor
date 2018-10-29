//
//  VersionUpdateManager.swift
//  GetDonor
//
//  Created by admin on 29/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import UIKit

class VersionUpdateManager{
    
    var apiLoader: APIRequestLoader<VersionUpdateApiRequest>!
    var model = VersionUpdateDataModel()
    var parentVC: UIViewController!
    
    init(onViewController: UIViewController, loader: APIRequestLoader<VersionUpdateApiRequest> = APIRequestLoader(apiRequest: VersionUpdateApiRequest())) {
        apiLoader = loader
        parentVC = onViewController
    }
    
    func checkVersionUpdate() {
        apiLoader.loadAPIRequest(forFuncion: .versionUpdate(os: "ios"), requestData: nil) { [weak self](response, error) in
            if let response = response{
                self?.model = response
                self?.showPopUp()
            }
        }
    }
    
    func showPopUp() {
        
        if let previousDate = GetDonorUserDefault.sharedInstance.getVersionUpdatePopUpDate(){
            
            let currentDate = Date(timeIntervalSinceNow: 0)
            
            if let diffInDays = Calendar.current.dateComponents([.day], from: previousDate, to: currentDate).day{
                
                if diffInDays > 0{
                    GetDonorUserDefault.sharedInstance.setUpdatePopUpFrequency(value: 0)
                    GetDonorUserDefault.sharedInstance.saveVersionUpdatePopUpDate()
                }

            }

            
        }
        else{
            GetDonorUserDefault.sharedInstance.saveVersionUpdatePopUpDate()
        }
        
        if let shouldShow = model.shouldShowUpDatePopUp {
            
            if shouldShow{
                let alert = UIAlertController(title: "", message: model.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
                    print("go to app store")
                    self.openUrl("itms-apps://itunes.apple.com/app/" + kAppId)
                    
                }))
                
                if !model.shouldForceUpdate! {
                    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
                }
                
                //self.present(alert, animated: true, completion: nil)
//                print(GetDonorUserDefault.sharedInstance.getUpdatePopUpFrequency())
//                print(model.updateFrequency)
                if model.updateFrequency! > GetDonorUserDefault.sharedInstance.getUpdatePopUpFrequency() || model.shouldForceUpdate!{
                    parentVC.topViewController().present(alert, animated: true) {
                        GetDonorUserDefault.sharedInstance.increasePopUpFrequency()
                    }
                    if model.shouldForceUpdate!{
                        GetDonorUserDefault.sharedInstance.setUpdatePopUpFrequency(value: 0)
                    }

                }

            }
            else{
                GetDonorUserDefault.sharedInstance.setUpdatePopUpFrequency(value: 0)
            }

        }
        
        
    }
    fileprivate func openUrl(_ urlString:String) {
        let url = URL(string: urlString)!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    
    
}
