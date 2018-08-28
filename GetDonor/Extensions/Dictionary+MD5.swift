//
//  Dictionary+MD5.swift
//  GetDonor
//
//  Created by admin on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

extension Dictionary{
    
    var md5WithSecretKey: String{
        
        
        var someString = AppBaseURLs.apiSecretKey + self.compactMap(){ $0.value as? String }.joined(separator: "")
        
        return someString.utf8.md5.description
        }
    
}
