//
//  PromotionTitleTableViewCell.swift
//  GetDonor
//
//  Created by admin on 11/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PromotionTitleTableViewCell: UITableViewCell, CellReusable {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
