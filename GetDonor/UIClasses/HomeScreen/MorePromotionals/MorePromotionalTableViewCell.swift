//
//  MorePromotionalTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import SDWebImage

class MorePromotionalTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.image = #imageLiteral(resourceName: "default")
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
    }
    
    func configureCell(with model: ContentDataModel?) {
        if let model = model {
            lblTitle.text = model.title
            guard let imageUrl = model.image else {return}
            imgView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
        }
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
