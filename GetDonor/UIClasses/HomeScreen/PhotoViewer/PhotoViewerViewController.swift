//
//  PhotoViewerViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoViewerViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    var imageArray: [ContentDataModel]!
    var imageLoader: APIRequestLoader<ImageRequest>!
    var selectedIndex: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        guard imageArray.count > 0 else {
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
            let model = self.imageArray[indexPath.item]
            loadImageView(model: model)
            lblTitle.text = model.title

        }
        else{
            if imageArray.count > 0{
                loadImageView(model: self.imageArray[0])
                lblTitle.text = self.imageArray.first?.title
            }

        }
        
    }
    func loadImageView(model: ContentDataModel)  {
        
        guard let imageUrl = model.image else { return  }
        
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
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoViewerCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(model: imageArray[indexPath.item])
        if indexPath == selectedIndex {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let model = self.imageArray[indexPath.item]
        loadImageView(model: model)
        lblTitle.text = model.title ?? ""
    }
    
}





