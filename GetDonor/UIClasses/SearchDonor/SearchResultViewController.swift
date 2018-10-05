//
//  SearchResultViewController.swift
//  GetDonor
//
//  Created by admin on 27/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class SearchResultViewController: BaseViewController {

    var bloodGroup: String!
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.estimatedRowHeight = 120
        tableview.rowHeight = UITableViewAutomaticDimension
        self.title = "Near by Doners"
        showLoader(onViewController: self)
        searchDonor()
    }
    
    func searchDonor() {
        viewModel.serachUser(bloodGroup: bloodGroup) {[weak self] (result) in
            self?.removeLoader(fromViewController: self!)
            self?.isLoadingNextPageResult(false)
            self?.viewModel.isLoadingNextPageResults = false
            switch result{
            case .Success:
                print("Success")
                self?.tableview.reloadData()
            case .failure(let msg):
                print(msg)
            }
        }
    }
    deinit {
        viewModel.apiLoader.cancelTask()
    }

}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.donors.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("cell: \(indexPath.row)")
        if indexPath.row == viewModel.model.donors.count - 1{
            if viewModel.canLoadNextPage() {
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                searchDonor()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell: SearchDonorTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.model.donors[indexPath.row])
        return cell
    }
    
}






