//
//  BaseViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addProfileButton()
    }
    
    func hideProfileButton()  {
        if let button = self.navigationItem.rightBarButtonItem {
            button.isEnabled = false
            button.tintColor = UIColor.clear
        }
        
    }
    func addProfileButton() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(openProfileScreen))
    }
    
    @objc func openProfileScreen() {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)
        
        
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
