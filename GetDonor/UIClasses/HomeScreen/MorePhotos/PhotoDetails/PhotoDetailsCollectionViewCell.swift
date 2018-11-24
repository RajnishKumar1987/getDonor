//
//  PhotoDetailsCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoDetailsCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(with imageUrl: String?) {
     
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))

        }
    }
    
}
