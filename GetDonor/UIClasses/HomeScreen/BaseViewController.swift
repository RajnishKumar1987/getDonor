//
//  BaseViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

let kLoaderViewTag = 1011
let kLoaderViewHeight: CGFloat = 50

enum navigationBarButtonType {
    case profile
    case share
    case none
}

class BaseViewController: UIViewController {
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var collectionview:UICollectionView!
    var isEnableRefreshControler:Bool = true
    var isNoInternetPresented: Bool = false
    @IBOutlet weak var listingContainerButtomConstaraints: NSLayoutConstraint!
    var controller: UISearchController!
    
    
    lazy var refreshControl: UIRefreshControl? = {
        let rControl = UIRefreshControl()
        rControl.tintColor = UIColor.colorFor(component: .navigationBar)
        rControl.backgroundColor = UIColor.groupTableViewBackground
        rControl.addTarget(self, action:
            #selector(refreshPage),
                           for: UIControlEvents.valueChanged)
        return rControl
    }()
    
    lazy var profileBarButton: UIBarButtonItem? = {
        return UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(openProfileScreen))
    }()
    
    lazy var shareBarButton: UIBarButtonItem? = {
        let btnShare = UIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(shareButtonPressed))
        return btnShare
    }()
    
    lazy var paginationLoaderView: UIView? = {
        
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - (kLoaderViewHeight + getTabBarHeight()) , width: self.view.frame.size.width, height: kLoaderViewHeight))
        view.backgroundColor = UIColor.white
        view.tag = kLoaderViewTag
        
        let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicatorView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        indicatorView.startAnimating()
        indicatorView.color = UIColor.colorFor(component: .navigationBar)
        indicatorView.isHidden = false
        view.addSubview(indicatorView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEnableRefreshControler {
            self.setUpRefreshActivityController()
        }
        if let _ = tableview {
            tableview.registerCell(CarouselTableViewCell.self)
            tableview.separatorInset.left = 15
            tableview.separatorInset.right = 15
        }
        addProfileButton()
        
    }
    
    func shouldShowSearchBar(value: Bool, viewController: UIViewController) {
        
        if value {
            controller = UISearchController(searchResultsController: nil)
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.placeholder = "Search"
            controller.searchBar.delegate = self
            definesPresentationContext = true
            
            if let tblView = tableview{
                tblView.tableHeaderView = controller.searchBar
            }
            if let collection = collectionview{
                collection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
               let someView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:66))
                someView.backgroundColor = UIColor.white
                someView.addSubview(controller.searchBar)
                collectionview.addSubview(someView)
            }
        }
        else{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.appDelegate().retry.bind { [weak self](vc) in
            if vc == self{
                self?.showLoader(onViewController: self!)
                self?.refresingPage()
            }
        }
        
    }
    
    func configureNavigationBarButton(buttonType: navigationBarButtonType) {
        
        switch buttonType {
        case .profile:
            self.navigationItem.rightBarButtonItem = profileBarButton
        case .share:
            self.navigationItem.rightBarButtonItem = shareBarButton
        case .none:
            hideProfileButton()
        }
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
    @objc func shareButtonPressed() {
        self.presentActivityViewController()
    }

    @objc private func refreshPage(){
        self.refresingPage()
    }
    
    func presentActivityViewController() {
    }
    
    func refresingPage() {
    }
    
    func isLoadingNextPageResult(_ isLoading: Bool) {
        
        if isLoading {
            listingContainerButtomConstaraints.constant = kLoaderViewHeight
            self.view.addSubview(paginationLoaderView!)
        }
        else {
            self.listingContainerButtomConstaraints.constant = 0
            let view = self.view.viewWithTag(kLoaderViewTag)
            view?.removeFromSuperview()
        }
        self.view.layoutIfNeeded()
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
    
    func searchBarCancelButtonClicked() {
    }
    func searchBarSearchButtonClicked(text: String) {
    }
    

}

extension BaseViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            self.searchBarSearchButtonClicked(text: text)
        }

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel")
        self.searchBarCancelButtonClicked()

    }
}


