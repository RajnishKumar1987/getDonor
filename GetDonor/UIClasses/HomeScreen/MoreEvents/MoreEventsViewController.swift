//
//  MoreEventsViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreEventsViewController: BaseViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableViewButtomConstaraints: NSLayoutConstraint!
    let viewModel = MoreEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        doInitialConfig()
    }
    
    func doInitialConfig() {
        loadMoreEvents()
        configureRefershControl(on: tableView)
    }
    
    func loadMoreEvents() {
        
        viewModel.loadMoreEvents { [weak self](result) in
            self?.activityIndicator.stopAnimating()
            self?.refreshControl?.endRefreshing()
            switch (result){
            case .Success:
                print("Success")
                self?.tableView.reloadData()
            case .failure(let msg):
                print(msg)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1/3) , execute: {
                self?.isLoadingNextPageResults(false)
                self?.viewModel.isUserRefreshingList = false

            })
            
        }
        
        
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

extension MoreEventsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.eventList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreEventTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if indexPath.row == viewModel.model.eventList.count - 1 {
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.getModelForCell(at: indexPath)
        let storyboard = UIStoryboard(name: "PhotoViewer", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PhotoViewerViewController") as! PhotoViewerViewController
        vc.selectedIndex = IndexPath(item: 0, section: 0)
        if let extraData = model.data {
            vc.viewModel = PhotoViewerViewModel(with: extraData)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension MoreEventsViewController{
    
    func configureRefershControl(on collectionView: UITableView) {
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refershPhotosList), for: .valueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.tableView.refreshControl = refreshControl
        
    }
    
    @objc func refershPhotosList()  {
        
        viewModel.isUserRefreshingList = true
        refreshControl?.beginRefreshing()
        loadMoreEvents()
    }
}

//MARK: - Lazy loading functionality

extension MoreEventsViewController {
    
    func loadNextPageResults() {
        loadMoreEvents()
    }
    
    func isLoadingNextPageResults(_ isLoading: Bool) {
        
        viewModel.isLoadingNextPageResults = isLoading
        
        if isLoading {
            tableViewButtomConstaraints.constant = kLoaderViewHeight
            addLoaderViewForNextResults()
        }
        else {
            
            self.tableViewButtomConstaraints.constant = 0
            
            let view = self.view.viewWithTag(kLoaderViewTag)
            view?.removeFromSuperview()
        }
        
        self.view.layoutIfNeeded()
    }
    
    
}






