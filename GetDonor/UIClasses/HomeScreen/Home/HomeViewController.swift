//
//  ViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
class HomeViewController: BaseViewController {
    
    var viewModel = HomeListingViewModel()
    var versionCheck: VersionUpdateManager??
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        doInitialConfig()
        enableRefresh()
        NotificationCenter.default.addObserver(self, selector: #selector(checkVersionUpdate), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.doInitialConfig), name: .loginSuccessful, object: nil)
        }
//    override func viewWillAppear(_ animated: Bool) {
//        if !AppConfig.getUserLoginStatus() {
//            presentLoginSignUpScreen()
//        }
//    }
    
    override func refresingPage() {
        self.loadHomeScreen()
    }
    
    @objc func doInitialConfig() {
        self.title = "Home"
        tableview.registerCell(CarouselTableViewCell.self)
        print("login status = \(GetDonorUserDefault.sharedInstance.getUserLoginStatus())")
        if !GetDonorUserDefault.sharedInstance.getUserLoginStatus() {
            presentLoginSignUpScreen()
        }else{
           showLoader(onViewController: self)
            loadHomeScreen()
            self.versionCheck = VersionUpdateManager(onViewController: self)
            versionCheck??.checkVersionUpdate()
        }
    }
    func presentLoginSignUpScreen() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "openLoginSignUp", sender: nil)
        })

    }
    
    @objc func checkVersionUpdate() {
        
        if let version = versionCheck{
            if let shouldForceUpdate = version?.model.shouldForceUpdate {
                        if shouldForceUpdate{
                            version?.checkVersionUpdate()
                        }
                    }
        }
        
        
    }
    
    func loadHomeScreen() {
        
        if self.checkInternetStatus(viewController: self, navigationBarPresent: true){
            viewModel.loadHomeScreen { [weak self](result) in
                self?.removeLoader(fromViewController: self!)
                self?.refreshControl?.endRefreshing()
                switch result {
                case .Success:
                    self?.tableview.reloadData()
                case .failure(let message):
                    print(message)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "openVideoDetails":
            let videoDetailsVC = segue.destination as? VideoDetailsViewController
            videoDetailsVC?.model = sender as! ContentDataModel
        case "openArticlesDetails":
            let articleDetailVC = segue.destination as? ArticleDetailsViewController
            articleDetailVC?.articles = [sender as? ContentDataModel] as? [ContentDataModel]
        case "openPhotoViewer":
            let articleDetailVC = segue.destination as? PhotoViewerViewController
            articleDetailVC?.selectedIndex = sender as? IndexPath
            articleDetailVC?.imageArray = viewModel.homeApiResponse?.contents?.photo
        case "openEditProfile":
            let videoDetailsVC = segue.destination as? EditProfileViewController
            videoDetailsVC?.userId = GetDonorUserDefault.sharedInstance.getUserId()
            print("openEditProfile")
        case "showEventsPhoto":
            let articleDetailVC = segue.destination as? PhotoViewerViewController
            var indexPath = sender as? IndexPath
            indexPath?.section = 0
            articleDetailVC?.selectedIndex = IndexPath(item: 0, section: 0)
            let model = viewModel.homeApiResponse?.contents?.event![(indexPath?.item)!]
            articleDetailVC?.imageArray = model?.data?.compactMap({ (data) -> ContentDataModel in
                ContentDataModel(id: data.id, image: data.imageUrl, title: data.title, insertdate: "", priority: "", status: "", updatedate: "", description: "", data: nil, type: ContentType.photo.rawValue, s_url:model?.s_url)
            })
        case "openPromotionDetails":
            let promotionDetailsVC = segue.destination as? PromotionDetailsViewController
            var indexPath = sender as? IndexPath
            let promotionBannerModel = viewModel.homeApiResponse?.contents?.topBanner![(indexPath?.row)!]
            promotionDetailsVC?.contentId = promotionBannerModel?.id
            
            print("")
        default:
            print("Unknown")
            
        }
        
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        if let segue = segue as? UIStoryboardSegueWithCompletionHandler {
            segue.completion = {
                if segue.identifier == "Logout" {
                    self.presentLoginSignUpScreen()
                }
                else{
                    self.performSegue(withIdentifier: "openEditProfile", sender: nil)
                    self.loadHomeScreen()
                }
                
            }
        }
        
    }
    
    func loadEditProfile() {
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

    }
    
    
    
}

extension HomeViewController: HomeScreenCellDelegate{
    
    func didCellSelected(at indexPath: IndexPath, with cellType: HomeScreenCellType) {
        
        switch cellType {
        case .video:
            let model = viewModel.homeApiResponse?.contents?.video![indexPath.item]
            self.performSegue(withIdentifier: "openVideoDetails", sender: model)
        case .article:
            let model = viewModel.homeApiResponse?.contents?.article![indexPath.item]
            self.performSegue(withIdentifier: "openArticlesDetails", sender: model)
        case .photo:
            self.performSegue(withIdentifier: "openPhotoViewer", sender: indexPath)
        case .event:
            self.performSegue(withIdentifier: "showEventsPhoto", sender: indexPath)
        case .promotional:
            self.performSegue(withIdentifier: "openPromotionDetails", sender: indexPath)
        case .social:
            let model = viewModel.homeApiResponse?.contents?.social![indexPath.item]
            if let url = model?.link{
                openUrl(urlString: url)
            }
        }
    }
    
    
    func didMoreButtonPressed(at cellType: HomeScreenCellType) {
        
        switch cellType {
        case .video:
            loadViewControllerWith(viewControllerIdentifier: "MoreVideosViewController", andStoryboardName: "Videos")
        case .article:
            loadViewControllerWith(viewControllerIdentifier: "MoreArticlesViewController", andStoryboardName: "Articles")
        case .photo:
            loadViewControllerWith(viewControllerIdentifier: "MorePhotosViewController", andStoryboardName: "Photos")
        case .event:
            loadViewControllerWith(viewControllerIdentifier: "MoreEventsViewController", andStoryboardName: "Events")
        case .promotional:
            loadViewControllerWith(viewControllerIdentifier: "MorePromotionalViewController", andStoryboardName: "Promotional")
        case .social:
            print("")
        }
    }
    
    func loadViewControllerWith(viewControllerIdentifier identifier:String, andStoryboardName storyboardName: String) {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let targetViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        self.navigationController?.pushViewController(targetViewController, animated: true)
        
        
    }
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = viewModel.cellTypes[indexPath.row]
        
        switch cellType {
        case .video:
            //            let cell: HomeVideoTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            //            cell.configurecell(model: viewModel.homeApiResponse?.contents?.video)
            // let c_model = CarouselDataModel(with: viewModel.homeApiResponse?.contents?.video)
            // print(c_model)
            let cell: CarouselTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.homeApiResponse?.contents?.video, and: .carousel(title: "Videos", cellType: .video))
            
            cell.delegate = self
            return cell
        case .article:
            let cell: HomeArticleTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.homeApiResponse?.contents?.article)
            cell.delegate = self
            return cell
        case .photo:
            let cell: HomePhotoTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.homeApiResponse?.contents?.photo)
            cell.delegate = self
            return cell
        case .event:
            let cell: HomeEventTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.homeApiResponse?.contents?.event)
            cell.delegate = self
            return cell
        case .promotional:
            let cell: CarouselTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.homeApiResponse?.contents?.topBanner, and: .carousel(title: "Promos", cellType: .promotional))
            cell.delegate = self
            return cell
        case .social:
            let cell: HomeSocialTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.homeApiResponse?.contents?.social)
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = viewModel.cellTypes[indexPath.row]
        
        switch cellType {
        case .video, .promotional:
            return kCarouselHeight
        case .article:
            return 125
        case .social:
            return 125
        default:
            return 180
        }
        
    }
    
    
}



