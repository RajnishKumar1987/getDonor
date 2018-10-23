//
//  ProfileTableViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 07/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class ProfileTableViewController: UITableViewController {

    var viewModel = MenuViewModel()
    var mc: MFMailComposeViewController!

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
           
            switch model.name{
            case "Rate":
                    loadRateTheAppView()
            case "Share":
                shareApp(model: model)
            case "Feedback":
                openFeedback()
            case "Edit":
                performSegue(withIdentifier: model.name!, sender: nil)
            case "Donation Details":
                performSegue(withIdentifier: model.name!, sender: nil)
            case "Logout":
                self.performSegue(withIdentifier: model.name!, sender: nil)
            default:
                print("Unknown")
            }
        default:
            print("Unknown")
    }
    }
    
    func openFeedback() {
        let emailTitle = "Feedback"
        //let messageBody = "Feature request or bug report?"
        let toRecipents = ["feedback@getdonor.org"]
        mc = MFMailComposeViewController()
        guard (mc) != nil else { return }
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        //mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.present(mc, animated: true, completion: nil)

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
            rateApp()
        }
    }
    
    func shareApp(model: Menu)  {
        
        if let shareUrl = URL(string: model.url ?? ""), let text = model.text {
            let shareAll = [text, shareUrl] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)

        }
    }

    
    fileprivate func rateApp() {
        openUrl("itms-apps://itunes.apple.com/app/" + kAppId)
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
            self.navigationController?.popViewController(animated: true)
        case "Donation Details":
            print("")
            
        default:
            print("Unknown")
        }
    }
    
}

extension ProfileTableViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)

    }
}
