//
//  ProfileViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideProfileButton()
        self.title = "Profile"
        doIniticalConfug()
    }
    
    func doIniticalConfug() {
        containerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.black, radius: 4.0, opacity: 0.35)
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
