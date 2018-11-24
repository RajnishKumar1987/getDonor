//
//  PhotosCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell,CellReusable {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }

    func configureCell(with model: ContentDataModel?) {
        
        
        guard let model = model else { return }
        
        lblTitle.text = model.title ?? ""
        
        if let imageUrl = model.image {
            imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))

        }
        
    }
    
}
