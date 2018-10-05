//
//  SeeAllVideosViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
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
    }
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        refreshControl?.beginRefreshing()
        loadVideos()
    }
    
    func doInitialConfig() {
        tableview.estimatedRowHeight = 240
        tableview.rowHeight = UITableViewAutomaticDimension
        showLoader(onViewController: self)
        loadVideos()
    }
    
    func loadVideos() {
        viewModel.loadMoreVideos { [weak self] (result) in
            self?.removeLoader(fromViewController: self!)
            self?.refreshControl?.endRefreshing()
            self?.viewModel.isLoadingNextPageResults = false
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
                loadVideos()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreVideosTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
    }
}








