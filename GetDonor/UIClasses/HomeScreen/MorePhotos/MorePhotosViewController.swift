//
//  MorePhotosViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit


class MorePhotosViewController: BaseViewController {
    
    var viewModel = MorePhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phots"
        doInitialConfig()
        enableRefresh()
        shouldShowSearchBar(value: true, viewController: self)

    }

    func doInitialConfig() {
        showLoader(onViewController: self)
        loadMorePhotos()
    }
    
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        loadMorePhotos()
    }
    
    func loadMorePhotos() {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.loadMorePhotos { [weak self](result) in
                self?.removeLoader(fromViewController: self!)
                self?.isLoadingNextPageResult(false)
                self?.viewModel.isUserRefreshingList = false
                self?.refreshControl?.endRefreshing()
                self?.viewModel.isLoadingNextPageResults = false
                switch (result){
                case .Success:
                    print("success")
                    self?.collectionview.reloadData()
                case .failure(let msg):
                    print(msg)
                }
            }
        }
    }
    
    func searchPhotoFor(keyword: String) {
        if checkInternetStatus(viewController: self, navigationBarPresent: true) {
            viewModel.serachPhotoFor(keyword: keyword) { [weak self] (result) in
                self?.removeLoader(fromViewController: self!)
                self?.refreshControl?.endRefreshing()
                self?.viewModel.isLoadingNextPageResults = false
                self?.isLoadingNextPageResult(false)
                self?.viewModel.isUserRefreshingList = false
                switch (result){
                case .Success:
                    self?.collectionview.reloadData()
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
            self.collectionview.setContentOffset( CGPoint(x: 0, y: -70) , animated: false)
            loadMorePhotos()
        }
    }
    override func searchBarSearchButtonClicked(text: String) {
        showLoader(onViewController: self)
        viewModel.isUserRefreshingList = true
        viewModel.isSearching = true
        searchPhotoFor(keyword: text)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? MorePhotosCollectionViewCell, var indexPath = collectionview.indexPath(for: cell) {
            
            let photoViewerVc = segue.destination as? PhotoViewerViewController
            photoViewerVc?.viewModel = PhotoViewerViewModel(with: viewModel.model.photoList)
            indexPath.section = 0
            photoViewerVc?.selectedIndex = indexPath
            //            let photoDetailsVC = segue.destination as? PhotoDetailsViewController
            //            indexPath.section = 0
            //            photoDetailsVC?.selectedIndexPath = indexPath
            //            photoDetailsVC?.photos = viewModel.model.photoList
        }
    }
    deinit {
        viewModel.apiLoader.cancelTask()
    }
    
    
}

extension MorePhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return viewModel.model.photoList.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == viewModel.model.photoList.count - 1 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                if viewModel.isSearching{
                    searchPhotoFor(keyword: self.controller.searchBar.text!)
                }else{
                    loadMorePhotos()
                }

            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: MorePhotosHeaderCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
            return cell
        default:
            let cell: MorePhotosCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: 35)
            
        default:
            
            if indexPath.item % 5 == 0{
                return CGSize(width: (collectionView.frame.size.width - 16), height: ((collectionView.frame.size.width) / 1.5))
                
            }
            else{
                return CGSize(width: (collectionView.frame.size.width - 24) / 2, height: ((collectionView.frame.size.width - 26) / 2) - 20)
                
            }
            
        }
    }
    
}





