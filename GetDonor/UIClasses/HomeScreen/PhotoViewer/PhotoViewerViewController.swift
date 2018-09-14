//
//  PhotoViewerViewController.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoViewerViewController: UIViewController {

    @IBOutlet weak var collectionViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: PhotoViewerViewModel!
    var imageLoader: APIRequestLoader<ImageRequest>!
    var selectedIndex: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard viewModel.model.images.count > 0 else {
            return
        }
        imageLoader = APIRequestLoader(apiRequest: ImageRequest())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.layoutIfNeeded()
        collectionView.layoutSubviews()
        
        if let indexPath = selectedIndex {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            loadImageView(from: viewModel.model.images[indexPath.item])

        }
        
    }
    func loadImageView(from imageUrl: String)  {
        imageLoader.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil) {[weak self] (image, error) in
            if let image = image{
                self?.imageView.image = image
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension PhotoViewerViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoViewerCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(imageUrl: viewModel.model.images[indexPath.row])
        if indexPath == selectedIndex {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        loadImageView(from: viewModel.model.images[indexPath.item])
    }
    
}





