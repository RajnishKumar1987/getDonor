//
//  DonateQ&ATableViewCell.swift
//  GetDonor
//
//  Created by admin on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonateQ_ATableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var lblQestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblQestion.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        lblAnswer.font = UIFont.fontWithTextStyle(textStyle: .regular)
    }

    func configureCell(with model: DonateTableViewCellModel?) {
        if let model = model as? DonateQandACellViewModel {
            self.lblQestion.text = model.question ?? ""
            self.lblAnswer.text = model.answer ?? ""
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
