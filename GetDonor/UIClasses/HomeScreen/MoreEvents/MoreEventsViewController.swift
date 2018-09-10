//
//  MoreEventsViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreEventsViewController: BaseViewController {

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
            
            self?.refreshControl?.endRefreshing()

            switch (result){
            case .Success:
                print("Success")
                self?.tableView.reloadData()
            case .failure(let msg):
                print(msg)
            }
            
            self?.isLoadingNextPageResults(false)
            self?.viewModel.isUserRefreshingList = false

            
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard viewModel.canLoadNextPage() else {
            return
        }
        
        let margin: CGFloat = 30
        let heightToLoadNextPage: CGFloat = scrollView.contentSize.height + margin
        let currentPosition: CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if (currentPosition >= heightToLoadNextPage) {
            isLoadingNextPageResults(true)
            loadNextPageResults()
            print("loadNextPageResults")
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






