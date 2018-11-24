//
//  PhotoViewerViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoViewerViewController: BaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    var imageArray: [ContentDataModel]!
    var selectedIndex: IndexPath?
    var selectedImage: ContentDataModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        configureNavigationBarButton(buttonType: .share)
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        guard imageArray.count > 0 else {
            return
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.layoutIfNeeded()
        collectionView.layoutSubviews()
        
        if let indexPath = selectedIndex {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            let model = self.imageArray[indexPath.item]
            selectedImage = model
            loadImageView(model: model)
            lblTitle.text = model.title

        }
        else{
            if imageArray.count > 0{
                loadImageView(model: self.imageArray[0])
                lblTitle.text = self.imageArray.first?.title
                selectedImage = self.imageArray[0]
            }

        }
        
    }
    
    override func shareButtonPressed() {
        let model = ShareDataModel(title: selectedImage.title, image: selectedImage.image, shareURL: selectedImage.s_url)
        showShareActivity(model: model)

    }
    
    func loadImageView(model: ContentDataModel)  {
        
        guard let imageUrl = model.image else { return  }
        
        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))

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
        selectedImage = model
        loadImageView(model: model)
        lblTitle.text = model.title ?? ""
        selectedIndex = indexPath
    }
    
}





