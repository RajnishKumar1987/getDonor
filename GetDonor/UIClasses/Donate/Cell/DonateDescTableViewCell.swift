//
//  DonateDescTableViewCell.swift
//  GetDonor
//
//  Created by admin on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonateDescTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var lblDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblDesc.font = UIFont.fontWithTextStyle(textStyle: .regular)
    }
    
    func configureCell(with model: DonateTableViewCellModel?)  {
        if let model = model as?  DonateDescriptionCellViewModel{
            self.lblDesc.text = model.info ?? ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
