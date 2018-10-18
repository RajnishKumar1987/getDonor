//
//  NavigationViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWithTextStyle(textStyle: .headline)]
        self.navigationBar.barTintColor = UIColor.colorFor(component: .navigationBar)

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
