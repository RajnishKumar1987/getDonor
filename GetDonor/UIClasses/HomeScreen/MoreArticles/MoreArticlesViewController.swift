//
//  MoreArticlesViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreArticlesViewController: BaseViewController {
    
    var viewModel = ArticlesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articles"
        tableview.alpha = 0
        doInitialConfig()
        enableRefresh()
        shouldShowSearchBar(value: true, viewController: self)
    }
    
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        loadArticles()
    }
    func doInitialConfig()  {
        
        tableview.estimatedRowHeight = 140
        tableview.rowHeight = UITableViewAutomaticDimension
        showLoader(onViewController: self)
        loadArticles()
    }
    
    func loadArticles() {
        
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.loadArticles { [weak self](result) in
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
        
    }
    
    func searchArticleFor(keyword: String) {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.serachArticleFor(keyword: keyword) { [weak self] (result) in
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
            loadArticles()
            
        }
    }
    override func searchBarSearchButtonClicked(text: String) {
        showLoader(onViewController: self)
        viewModel.isUserRefreshingList = true
        viewModel.isSearching = true
        searchArticleFor(keyword: text)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? ArticlesTableViewCell, let indexPath = tableview.indexPath(for: cell) {
            
            if let  articleDeatilsVC = segue.destination as? ArticleDetailsViewController{
                
                articleDeatilsVC.loadArticlsWith(model: self.viewModel.model.articleList, withSelected: indexPath)
            }
            
        }
    }
    
    deinit {
        viewModel.apiLoader.cancelTask()
    }
    
}

extension MoreArticlesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.articleList.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.model.articleList.count - 1 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                if viewModel.isSearching{
                    searchArticleFor(keyword: self.controller.searchBar.text!)
                }else{
                    loadArticles()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell: ArticlesTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}





