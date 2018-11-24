//
//  PhotoViewerCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoViewerCollectionViewCell: UICollectionViewCell,CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
    

    }
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                self.contentView.backgroundColor = UIColor.red
                //self.tickImageView.isHidden = false
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.backgroundColor = UIColor.gray
                //self.tickImageView.isHidden = true
            }
        }
    }
  
    
    func configureCell(model: ContentDataModel) {
        
        guard let imageUrl = model.image else { return }
        
        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))

        
    }
}
