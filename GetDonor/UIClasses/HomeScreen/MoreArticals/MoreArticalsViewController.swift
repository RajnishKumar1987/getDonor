//
//  MoreArticalsViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreArticalsViewController: BaseViewController {

    var viewModel = ArticalsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articals"
        tableview.alpha = 0
        doInitialConfig()
        enableRefresh()
    }

    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        refreshControl?.beginRefreshing()
        loadArticals()
    }
    func doInitialConfig()  {
        
        tableview.estimatedRowHeight = 140
        tableview.rowHeight = UITableViewAutomaticDimension
        showLoader(onViewController: self)
        loadArticals()
    }
    
    func loadArticals() {
        
        viewModel.loadArticals { [weak self](result) in
            self?.removeLoader(fromViewController: self!)
            self?.refreshControl?.endRefreshing()
            self?.viewModel.isLoadingNextPageResults = false
            self?.isLoadingNextPageResult(false)
            switch (result){
            case .Success:
                self?.tableview.alpha = 1
                self?.tableview.reloadData()
                print("Success")
            case .failure(let msg):
                print(msg)
            }
        }
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? ArticalsTableViewCell, let indexPath = tableview.indexPath(for: cell) {
            
            if let  articalDeatilsVC = segue.destination as? ArticalDetailsViewController{
                
                articalDeatilsVC.loadArticlsWith(model: self.viewModel.model.articalList, withSelected: indexPath)
            }
            
        }
    }
    
    deinit {
        viewModel.apiLoader.cancelTask()
    }

}

extension MoreArticalsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.articalList.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.model.articalList.count - 1 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                loadArticals()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell: ArticalsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
        
    }
    
}





