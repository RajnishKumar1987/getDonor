//
//  BaseViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var collectionview:UICollectionView!
    var isEnableRefreshControler:Bool = true
    var isEnablePagination: Bool = true
    
    lazy var refreshControl: UIRefreshControl? = {
        let rControl = UIRefreshControl()
        rControl.tintColor = UIColor.colorFor(component: .navigationBar)
        rControl.addTarget(self, action:
            #selector(refreshPage),
                           for: UIControlEvents.valueChanged)
        return rControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if isEnableRefreshControler {
            self.setUpRefreshActivityController()
        }

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
    @objc private func refreshPage(){
        
        self.refresingPage()
    }
    
    func refresingPage() {
        
    }

    
    func setUpRefreshActivityController(){
        if let tblView = self.tableview{
            tblView.alwaysBounceVertical = true
            tblView.bounces = true
            tblView.addSubview(self.refreshControl!)
            tblView.tag = 100
        }
        if let collection = self.collectionview{
            collection.alwaysBounceVertical = true
            collection.bounces = true
            collection.addSubview(self.refreshControl!)
            collection.tag = 100
        }
    }
    
    func enableRefresh() {
        if let tblView = self.tableview{
            tblView.alwaysBounceVertical = true
            tblView.bounces = true
        }
        if let collection = self.collectionview{
            collection.alwaysBounceVertical = true
            collection.bounces = true
        }
    }
    
    func disableRefresh() {
        if let tblView = self.tableview{
            tblView.alwaysBounceVertical = false
            tblView.bounces = false
        }
        if let collection = self.collectionview{
            collection.alwaysBounceVertical = false
            collection.bounces = false
        }
    }
    
    func uninstallRefreshController(){
        guard let _ = self.refreshControl else {
            return
        }
        self.refreshControl?.removeFromSuperview()
    }


    

}
