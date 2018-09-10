//
//  ViewController.swift
//  GetDonor
//
//  Created by admin on 22/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = HomeListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialConfig()
    }
    
    func doInitialConfig() {
                
        self.title = "Home"
        if AppConfig().getUserLoginStatus() {
            presentLoginSignUpScreen()
        }else{
            loadHomeScreen()

        }
    }
    func presentLoginSignUpScreen() {
        
        performSegue(withIdentifier: "openLoginSignUp", sender: nil)
    }
    
    func loadHomeScreen() {
        
        viewModel.loadHomeScreen { [weak self](result) in
            
            switch result {
            case .Success:
                self?.tableView.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "openVideoDetails":
            let videoDetailsVC = segue.destination as? VideoDetailsViewController
            videoDetailsVC?.model = sender as! Video
        case "openArticalsDetails":
            let articalDetailVC = segue.destination as? ArticalDetailsViewController
            articalDetailVC?.articals = [sender as? Article] as? [Article]
        case "openPhotoDetails":
            let articalDetailVC = segue.destination as? PhotoDetailsViewController
            articalDetailVC?.selectedIndexPath = sender as! IndexPath
            articalDetailVC?.photos = viewModel.homeApiResponse?.contents?.photo            
        default:
            print("Unknown")
            
        }
        
    }

    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        loadHomeScreen()
    }



}

extension HomeViewController: HomeScreenCellDelegate{
   
    func didCellSelected(at indexPath: IndexPath, with cellType: HomeScreenCellType) {
        
        switch cellType {
        case .video:
            let model = viewModel.homeApiResponse?.contents?.video[indexPath.item]
            self.performSegue(withIdentifier: "openVideoDetails", sender: model)
        case .artical:
            let model = viewModel.homeApiResponse?.contents?.article[indexPath.item]
            self.performSegue(withIdentifier: "openArticalsDetails", sender: model)
        case .photo:
            self.performSegue(withIdentifier: "openPhotoDetails", sender: indexPath)

        default:
            print("Unknown")
        }
    }
    
   
    func didMoreButtonPressed(at cellType: HomeScreenCellType) {
        
        switch cellType {
        case .video:
            loadViewControllerWith(viewControllerIdentifier: "MoreVideosViewController", andStoryboardName: "Videos")
        case .artical:
            loadViewControllerWith(viewControllerIdentifier: "MoreArticalsViewController", andStoryboardName: "Articals")
        case .photo:
            loadViewControllerWith(viewControllerIdentifier: "MorePhotosViewController", andStoryboardName: "Photos")
        case .event:
            loadViewControllerWith(viewControllerIdentifier: "MoreEventsViewController", andStoryboardName: "Events")

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
            let cell: HomeVideoTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configurecell(model: viewModel.homeApiResponse?.contents?.video)
            cell.delegate = self
            return cell
        case .artical:
            let cell: HomeArticalTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
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

        
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = viewModel.cellTypes[indexPath.row]
        
        switch cellType {
        case .video:
            return 270
        default:
            return 180
        }
        
    }
    
    
}



