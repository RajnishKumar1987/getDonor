//
//  UIStoryboardSegueWithCompletionHandler.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class UIStoryboardSegueWithCompletionHandler: UIStoryboardSegue {

    var completion: (() -> Void)?

    override func perform() {
        super.perform()
        if let completion = completion {
            completion()
        }
    }
    
    
}
