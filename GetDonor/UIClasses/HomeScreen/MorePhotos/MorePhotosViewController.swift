//
//  MorePhotosViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit


class MorePhotosViewController: BaseViewController {

    var viewModel = MorePhotosViewModel()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var constraintCollectionViewBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phots"
        collectionview.alpha = 0
        doInitialConfig()
        enableRefresh()
    }
    
    func doInitialConfig() {
        loadMorePhotos()
    }
    
    override func refresingPage() {
        viewModel.isUserRefreshingList = true
        refreshControl?.beginRefreshing()
        loadMorePhotos()

    }
    
    func loadMorePhotos() {
        
        viewModel.loadMorePhotos { [weak self](result) in
            self?.activityIndicator.stopAnimating()
            self?.isLoadingNextPageResults(false)
            self?.viewModel.isUserRefreshingList = false
            self?.refreshControl?.endRefreshing()
            switch (result){
            case .Success:
                print("success")
                self?.collectionview.alpha = 1
                self?.collectionview.reloadData()
            case .failure(let msg):
                print(msg)
            }
        }
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
            return CGSize(width: (collectionView.frame.size.width - 24) / 2, height: ((collectionView.frame.size.width - 26) / 2) - 20)

        }
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
        }
        
    }
}


//MARK: - Lazy loading functionality

let kLoaderViewTag = 1011
let kLoaderViewHeight: CGFloat = 50

extension MorePhotosViewController {
    
    func loadNextPageResults() {
        loadMorePhotos()
    }
    
    func isLoadingNextPageResults(_ isLoading: Bool) {
        
        viewModel.isLoadingNextPageResults = isLoading
        
        if isLoading {
            constraintCollectionViewBottomMargin.constant = kLoaderViewHeight
            addLoaderViewForNextResults()
            
        }
        else {
            
            self.constraintCollectionViewBottomMargin.constant = 0
            
            let view = self.view.viewWithTag(kLoaderViewTag)
            view?.removeFromSuperview()
        }
        
        self.view.layoutIfNeeded()
    }
    

}



