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
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var constraintCollectionViewBottomMargin: NSLayoutConstraint!
    var refreshControl: UIRefreshControl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phots"
        doInitialConfig()
    }
    
    func doInitialConfig() {
        loadMorePhotos()
        configureRefershControl(on: collectionView)
    }
    
    func loadMorePhotos() {
        
        viewModel.loadMorePhotos { [weak self](result) in
            
            self?.isLoadingNextPageResults(false)
            self?.viewModel.isUserRefreshingList = false
            self?.refreshControl?.endRefreshing()
            switch (result){
            case .Success:
                print("success")
                self?.collectionView.reloadData()
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

        if let cell = sender as? MorePhotosCollectionViewCell, var indexPath = collectionView.indexPath(for: cell) {
            
            let photoDetailsVC = segue.destination as? PhotoDetailsViewController
            indexPath.section = 0
            photoDetailsVC?.selectedIndexPath = indexPath
            photoDetailsVC?.photos = viewModel.model.photoList
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
            print("1234567890")
        }
        
    }
}



extension MorePhotosViewController{
    
    func configureRefershControl(on collectionView: UICollectionView) {
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refershPhotosList), for: .valueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.collectionView.refreshControl = refreshControl

    }
    
    @objc func refershPhotosList()  {
        
        viewModel.isUserRefreshingList = true
        refreshControl?.beginRefreshing()
        loadMorePhotos()
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

extension UIViewController{
    
    func getTabBarHeight() -> CGFloat {
        
        var tabbarHeight: CGFloat = CGFloat(0.0)
        if #available(iOS 11.0, *) {
            tabbarHeight = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! + 49
        } else {
            tabbarHeight = 49
        }
        
        return tabbarHeight
    }
    
    func addLoaderViewForNextResults() {
        
        
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - (kLoaderViewHeight + getTabBarHeight()) , width: self.view.frame.size.width, height: kLoaderViewHeight))
        view.backgroundColor = UIColor.lightGray
        view.tag = kLoaderViewTag
        
        let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicatorView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        indicatorView.startAnimating()
        indicatorView.color = UIColor.white
        indicatorView.isHidden = false
        view.addSubview(indicatorView)
        
        self.view.addSubview(view)
    }

}

