//
//  SeeAllVideosViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreVideosViewController: BaseViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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
        loadVideos()
    }
    
    func loadVideos() {
        
        viewModel.loadMoreVideos { [weak self] (result) in
            self?.activityIndicator.stopAnimating()
            self?.refreshControl?.endRefreshing()
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
    

}

extension MoreVideosViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.model.vidoeList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreVideosTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
        
    }
}








