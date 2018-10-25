//
//  LoginViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let apiLoader: APIRequestLoader<LoginApiRequest>!
    var model = LoginDataModel()
    
    init(loader: APIRequestLoader<LoginApiRequest> = APIRequestLoader(apiRequest: LoginApiRequest())) {
        self.apiLoader = loader
    }
    
    
    func login(with userName:String, and password:String, with result:@escaping(Result<String>)->Void) {
        
        apiLoader.loadAPIRequest(forFuncion: .login(userName: userName.toBase64(), password: password.toBase64()), requestData: nil) { (response, error) in
            
            if let response = response {
                
                if response.message == "successful"{
                    AppConfig.setUserId(id: response.userDetails?.userId ?? "")
                    AppConfig.setUserLoggedIn(status: true)
                    appDelegate.registerForPushNotifications()
                    LocationManager.sharedInstance.startLocaitonService()
                    self.model = response
                    result(.Success)

                }else
                {
                    result(.failure(response.message!))

                }
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
}
