//
//  SearchResultViewController.swift
//  GetDonor
//
//  Created by admin on 27/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var constraintTableViewBottomMargin: NSLayoutConstraint!
    var bloodGroup: String!
    var viewModel = SearchViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        searchDonor()
    }
    
    func searchDonor() {
        viewModel.serachUser(bloodGroup: bloodGroup) {[weak self] (result) in
            switch result{
            case .Success:
                print("Success")
                self?.tableView.reloadData()
            case .failure(let msg):
                print(msg)
            }
            self?.isLoadingNextPageResults(false)
        }
    }

}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.donors.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.model.donors.count - 1{
            if viewModel.canLoadNextPage() {
                isLoadingNextPageResults(true)
                loadNextPageResults()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell: SearchDonorTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.model.donors[indexPath.row])
        return cell
    }
    
}

//MARK: - Lazy loading functionality

extension SearchResultViewController {
    
    func loadNextPageResults() {
        searchDonor()
    }
    
    func isLoadingNextPageResults(_ isLoading: Bool) {
        
        viewModel.isLoadingNextPageResults = isLoading
        
        if isLoading {
            constraintTableViewBottomMargin.constant = kLoaderViewHeight
            addLoaderViewForNextResults()
            
        }
        else {
            
            self.constraintTableViewBottomMargin.constant = 0
            
            let view = self.view.viewWithTag(kLoaderViewTag)
            view?.removeFromSuperview()
        }
        
        self.view.layoutIfNeeded()
    }
    
    
}




