//
//  HomePhotoTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class HomePhotoTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var photosModelArray: [ContentDataModel]? = []
    weak var delegate: HomeScreenCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnMore.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title2)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureCell(with model: [ContentDataModel]?) {
        
        if let contentArray = model {
            photosModelArray = contentArray
            collectionView.reloadData()
        }
    }
    @IBAction func actionMorePhotsButtonPressed(_ sender: UIButton) {
        
        if (self.delegate != nil) {
            self.delegate?.didMoreButtonPressed(at: .photo)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomePhotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (photosModelArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PhotosCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: photosModelArray?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width - 26) / 2, height: self.bounds.size.height - 54)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let delegate = self.delegate else { return }
        delegate.didCellSelected(at: indexPath, with: .photo)
    }

}
