//
//  LoginViewModel.swift
//  GetDonor
//
//  Created by admin on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let apiLoader: APIRequestLoader<LoginApiRequest>!
    
    init(loader: APIRequestLoader<LoginApiRequest> = APIRequestLoader(apiRequest: LoginApiRequest())) {
        self.apiLoader = loader
    }
    
    
    func login(with userName:String, and password:String, with result:@escaping(Result<String>)->Void) {
        
        let requestParam = ["version":Bundle.main.versionNumber,"username":userName.toBase64(),"password":password.toBase64() , "token":"TOKEN"]
        
        apiLoader.loadAPIRequest(forFuncion: .login, requestData: requestParam) { (response, error) in
            
            if let response = response {
                
                if response.message == "successful"{
                    AppConfig.setUserId(id: response.userDetails?.userId ?? "")
                    AppConfig.setUserLoggedIn(status: true)
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
