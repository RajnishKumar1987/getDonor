//
//  MoreVideosTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreVideosTableViewCell: UITableViewCell, CellReusable{

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
    }

    func configureCell(with model: ContentDataModel?) {
        
        lblTitle.text = model?.title
        
        if let imageUrl = model?.image {
            imgView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))

        }
        
    }


}
