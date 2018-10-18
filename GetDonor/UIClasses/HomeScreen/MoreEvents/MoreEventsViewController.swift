//
//  MoreEventsViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreEventsViewController: BaseViewController {
    
    let viewModel = MoreEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        doInitialConfig()
        enableRefresh()
        shouldShowSearchBar(value: true, viewController: self)
    }
    
    func doInitialConfig() {
        tableview.estimatedRowHeight = 195
        tableview.rowHeight = UITableViewAutomaticDimension
        showLoader(onViewController: self)
        loadMoreEvents()
    }
    
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        loadMoreEvents()
    }
    
    func loadMoreEvents() {
        
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.loadMoreEvents { [weak self](result) in
                self?.removeLoader(fromViewController: self!)
                self?.refreshControl?.endRefreshing()
                self?.isLoadingNextPageResult(false)
                self?.viewModel.isUserRefreshingList = false
                
                switch (result){
                case .Success:
                    print("Success")
                    self?.tableview.reloadData()
                case .failure(let msg):
                    print(msg)
                }
                
            }
        }
    }
    func searchEventFor(keyword: String) {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.serachEventFor(keyword: keyword) { [weak self] (result) in
                self?.removeLoader(fromViewController: self!)
                self?.refreshControl?.endRefreshing()
                self?.viewModel.isLoadingNextPageResults = false
                self?.isLoadingNextPageResult(false)
                self?.viewModel.isUserRefreshingList = false
                switch (result){
                case .Success:
                    self?.tableview.reloadData()
                    print("Success")
                case .failure(let messgae):
                    print(messgae)
                }
            }
        }
    }
    
    override func searchBarCancelButtonClicked() {
        print("Cancel")
        if viewModel.isSearching {
            viewModel.isSearching = false
            viewModel.isUserRefreshingList = true
            showLoader(onViewController: self)
            self.tableview.setContentOffset( CGPoint(x: 0, y: -70) , animated: false)
            loadMoreEvents()
            
        }
    }
    override func searchBarSearchButtonClicked(text: String) {
        showLoader(onViewController: self)
        viewModel.isUserRefreshingList = true
        viewModel.isSearching = true
        searchEventFor(keyword: text)
    }
    
    deinit {
        viewModel.apiLoader.cancelTask()
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
        
        print("cell: \(indexPath.row)")
        if indexPath.row == viewModel.model.eventList.count - 1 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                if viewModel.isSearching{
                    searchEventFor(keyword: self.controller.searchBar.text!)
                }else{
                    loadMoreEvents()
                }
            }
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







