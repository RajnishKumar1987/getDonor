//
//  ProfileViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideProfileButton()
        self.title = "Profile"
        doIniticalConfug()

        imgProfile.makeCornerRadiusWithValue(imgProfile.frame.width/2)
        imgProfile.layer.borderWidth = 3
        imgProfile.layer.borderColor = UIColor.white.cgColor
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
        }
        NotificationCenter.default.addObserver(self, selector: #selector(getUserProfile), name: .profileUpdated, object: nil)
    }
    
    @objc func getUserProfile() {
        viewModel.getProfile(for: GetDonorUserDefault.sharedInstance.getUserId(), action: .get) { [weak self](result) in
            self?.loadProfilePic()
        }
    }
    
    func loadProfilePic() {
        if let imageUrl = GetDonorUserDefault.sharedInstance.getUserProfileImageUrl() {
            imgProfile.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
        }

    }
    
    override func refresingPage() {
        //self.performSegue(withIdentifier: "openMenu", sender: nil)
        if  let vc = self.childViewControllers.first as? ProfileTableViewController{
            if checkInternetStatus(viewController: self, navigationBarPresent: true) {
                vc.loadMenu()

            }

        }
        
    }
    
    func doIniticalConfug() {
        containerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.black, radius: 4.0, opacity: 0.35)
        getUserProfile()
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
