//
//  ArticleCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblDescription.font = UIFont.fontWithTextStyle(textStyle: .body)
    }

    func configurecell(model: ContentDataModel) {
        
        lblTitle.text = model.title ?? ""
        lblDescription.text = model.description ?? ""
        
        guard let imageUrl = model.image else { return }
        
        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
        
    }
}
