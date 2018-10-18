//
//  SignUpViewModel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class SignUpViewModel {
    
    let apiLoader: APIRequestLoader<SignUpApiRequest>!
    
    init(loader: APIRequestLoader<SignUpApiRequest> = APIRequestLoader(apiRequest: SignUpApiRequest())) {
        self.apiLoader = loader
    }
    
    
    func login(with userDetails:[String:String], andcompletionHandler result:@escaping(Result<String>)->Void) {
        
        apiLoader.loadAPIRequest(forFuncion: .registration, requestData: userDetails) { (response, error) in
            
            if let response = response {
                
                if response.message == "successful"{
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
