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
    var model = LoginDataModel()
    
    init(loader: APIRequestLoader<LoginApiRequest> = APIRequestLoader(apiRequest: LoginApiRequest())) {
        self.apiLoader = loader
    }
    
    
    func login(with userName:String, and password:String, with result:@escaping(Result<String>)->Void) {
        
        let requestParam = ["version":"1.0.0","username":"sendtorajnishkumar@gmail.com".toBase64(),"password":"12345678".toBase64() , "token":"TOKEN"]
        
        apiLoader.loadAPIRequest(forFuncion: .login, requestData: requestParam) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.model = response
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
}
