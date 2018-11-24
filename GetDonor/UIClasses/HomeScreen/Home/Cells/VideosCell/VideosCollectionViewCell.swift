//
//  VideosCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class VideosCollectionViewCell: UICollectionViewCell,CellReusable {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }

    func configureCell(model: ContentDataModel) {
        
        lblTitle.text = model.title ?? ""        
        guard let imageUrl = model.image else { return }
        
        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))

        
    }
}
