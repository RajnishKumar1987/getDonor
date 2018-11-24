//
//  MorePhotosCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import SDWebImage

class MorePhotosCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
       
    func configureCell(with model: ContentDataModel?) {
        
        if let model = model {
            lblName.text = model.title
            
            if let imageUrl = model.image {
                imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
            }
        }
        
    }
    
}
