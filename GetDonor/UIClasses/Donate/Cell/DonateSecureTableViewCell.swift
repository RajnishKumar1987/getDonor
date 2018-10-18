//
//  DonateSecureTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonateSecureTableViewCell: UITableViewCell,CellReusable {
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .regular)
    }
    func configureCell(with model: DonateTableViewCellModel?)  {
        if let model = model as? DonateScureCellViewModel {
            lblTitle.text = model.info ?? ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
