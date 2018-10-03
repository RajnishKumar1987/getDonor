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
    @IBOutlet weak var tableViewButtomConstaraints: NSLayoutConstraint!
    let viewModel = MoreEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        doInitialConfig()
        enableRefresh()
    }
    
    func doInitialConfig() {
        loadMoreEvents()
    }
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        refreshControl?.beginRefreshing()
        loadMoreEvents()
    }
    
    func loadMoreEvents() {
        
        viewModel.loadMoreEvents { [weak self](result) in
            self?.activityIndicator.stopAnimating()
            self?.refreshControl?.endRefreshing()
            switch (result){
            case .Success:
                print("Success")
                self?.tableview.reloadData()
            case .failure(let msg):
                print(msg)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1/3) , execute: {
                self?.isLoadingNextPageResults(false)
                self?.viewModel.isUserRefreshingList = false

            })
            
        }
        
    }
    
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






