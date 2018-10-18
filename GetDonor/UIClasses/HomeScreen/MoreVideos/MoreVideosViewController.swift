//
//  SeeAllVideosViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreVideosViewController: BaseViewController {
    
    var viewModel = MoreVideosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Videos"
        
        doInitialConfig()
        enableRefresh()
        shouldShowSearchBar(value: true, viewController: self)

    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        loadVideos()
    }
    
    func doInitialConfig() {
        tableview.estimatedRowHeight = 240
        tableview.rowHeight = UITableViewAutomaticDimension
        showLoader(onViewController: self)
        loadVideos()
    }
    
    func loadVideos() {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.loadMoreVideos { [weak self] (result) in
                self?.removeLoader(fromViewController: self!)
                self?.refreshControl?.endRefreshing()
                self?.viewModel.isLoadingNextPageResults = false
                self?.viewModel.isUserRefreshingList = false
                self?.isLoadingNextPageResult(false)
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
    
    func searchVideoFor(keyword: String) {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.serachVideoFor(keyword: keyword) { [weak self] (result) in
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
            loadVideos()

        }
    }
    override func searchBarSearchButtonClicked(text: String) {
        showLoader(onViewController: self)
        viewModel.isUserRefreshingList = true
        viewModel.isSearching = true
        searchVideoFor(keyword: text)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? MoreVideosTableViewCell, let indexPath = tableview.indexPath(for: cell) {
            let videoModel = viewModel.getModelForCell(at: indexPath)
            let videoDetailsVC = segue.destination as? VideoDetailsViewController
            videoDetailsVC?.model = videoModel
        }
    }
    
    deinit {
        viewModel.apiLoader.cancelTask()
    }
}

extension MoreVideosViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.vidoeList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.model.vidoeList.count - 3 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                if viewModel.isSearching{
                    searchVideoFor(keyword: self.controller.searchBar.text!)
                }else{
                    loadVideos()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreVideosTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
    }
}









