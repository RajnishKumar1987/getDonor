//
//  MoreEventTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 10/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreEventTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
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
    @IBAction func actionShareButtonPressed(_ sender: UIButton) {
        
    }
    
}
