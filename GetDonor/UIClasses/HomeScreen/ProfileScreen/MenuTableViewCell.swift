//
//  MenuTableViewCell.swift
//  GetDonor
//
//  Created by admin on 21/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
