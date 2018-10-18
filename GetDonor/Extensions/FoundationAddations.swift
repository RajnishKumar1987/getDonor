//
//  FoundationAddations.swift
//  SampleApp
//
//  Created by Rajnish kumar on 14/08/18.
//  Copyright © 2018 Rajnish kumar. All rights reserved.
//

import Foundation

extension Data {
    
    func toJSONObject() -> Any? {
        
        let object = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
        return object
    }
}


extension Dictionary {
    
    func toJSONData() -> Data? {
        
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return data
    }
}

extension Bundle{
    
    var versionNumber: String{
        return infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String{
        return infoDictionary!["CFBundleVersion"] as! String
    }
    
    
}
