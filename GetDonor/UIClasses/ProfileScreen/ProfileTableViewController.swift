//
//  ProfileTableViewController.swift
//  GetDonor
//
//  Created by admin on 07/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import StoreKit

class ProfileTableViewController: UITableViewController {

    var viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader(onViewController: self)
        tableView.layer.cornerRadius = 10
        loadMenu()
    }
    
    func loadMenu() {
        viewModel.loadMenu {[weak self] (result) in
            self?.removeLoader(fromViewController: self!)
            switch result{
            case .Success:
                print("success")
                self?.tableView.reloadData()
            case .failure(let msg):
                print(msg)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.model.menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.model.menu[indexPath.row]
        let cell: MenuTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.lblTitle.text = model.name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.model.menu[indexPath.row]
        
        switch model.type {
        case "webview":
            openWebView(with: model.url!)
        case "inapp":
            if model.name == "Rate the App"{
                loadRateTheAppView()
            }
            else{
                performSegue(withIdentifier: model.name!, sender: nil)

            }
        default:
            print("Unknown")
    }
    }
    
    func openWebView(with stringUrl: String)  {
        let storyBoard = UIStoryboard(name: "WebView", bundle: nil)
        let webViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webViewController.urlString = stringUrl
        self.navigationController?.pushViewController(webViewController, animated: true)

    }
    
    func loadRateTheAppView()  {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        }
        else{
            rateApp(appId: "id414009038")
        }
    }
    
    fileprivate func rateApp(appId: String) {
        openUrl("itms-apps://itunes.apple.com/app/" + appId)
    }
    fileprivate func openUrl(_ urlString:String) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "Edit":
            let vc = segue.destination as! EditProfileViewController
            vc.userId = AppConfig.getUserId()
        case "Logout":
            print("")
            AppConfig.setUserLoggedIn(status: false)
            self.navigationController?.popViewController(animated: false)
        case "Donation Details":
            print("")
            
        default:
            print("Unknown")
        }
    }
    

}
