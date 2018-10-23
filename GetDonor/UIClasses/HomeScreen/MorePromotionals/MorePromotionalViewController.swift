//
//  MorePromotionalViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MorePromotionalViewController: BaseViewController {
    
    let viewModel = MorePromotionalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Promos"
        tableview.estimatedRowHeight = 240
        tableview.rowHeight = UITableViewAutomaticDimension
        showLoader(onViewController: self)
        loadPromotionalList()
        enableRefresh()
        shouldShowSearchBar(value: true, viewController: self)
    }
    
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        loadPromotionalList()
    }
    
    func loadPromotionalList() {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.loadMorePromotional { [weak self](result) in
                self?.removeLoader(fromViewController: self!)
                self?.refreshControl?.endRefreshing()
                self?.viewModel.isLoadingNextPageResults = false
                self?.isLoadingNextPageResult(false)
                
                switch result{
                case .Success:
                    self?.tableview.reloadData()
                    print("Success")
                case .failure(let msg):
                    print(msg)
                }
            }
        }
    }
    
    func searchPromotionalsFor(keyword: String) {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.serachPromotionalFor(keyword: keyword) { [weak self] (result) in
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
        if viewModel.isSearching {
            viewModel.isSearching = false
            viewModel.isUserRefreshingList = true
            showLoader(onViewController: self)
            self.tableview.setContentOffset( CGPoint(x: 0, y: -70) , animated: false)
            loadPromotionalList()
        }
    }
    override func searchBarSearchButtonClicked(text: String) {
        showLoader(onViewController: self)
        viewModel.isUserRefreshingList = true
        viewModel.isSearching = true
        searchPromotionalsFor(keyword: text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPromotionalDetails", let indexPath = tableview.indexPath(for: sender as! UITableViewCell) {
            let vc = segue.destination as? PromotionDetailsViewController
            let model = viewModel.getModelForCell(at: indexPath)
            vc?.contentId = model.id
            
        }
        
    }
    
    
}

extension MorePromotionalViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.promotionalList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.model.promotionalList.count - 1 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                if viewModel.isSearching{
                    searchPromotionalsFor(keyword: self.controller.searchBar.text!)
                }else{
                    loadPromotionalList()
                }

            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MorePromotionalTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
        
    }
    
}





