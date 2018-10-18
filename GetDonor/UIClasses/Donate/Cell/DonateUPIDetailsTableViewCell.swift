//
//  DonateUPIDetailsTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonateUPIDetailsTableViewCell: UITableViewCell ,CellReusable{

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .regular)
        containerView.addShadow(offset: CGSize.init(width: 0, height: -1), color: UIColor.black, radius: 3.0, opacity: 0.25)

    }

    func configureCell(with model: DonateTableViewCellModel?)  {
        if let model = model as? DonateUPIDetailsCellViewModel {
            let phoneNumber = model.info?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            let stringWithoutNumber = model.info?.components(separatedBy: CharacterSet.decimalDigits).joined()
            let formattedString = NSMutableAttributedString()
            formattedString.normal(stringWithoutNumber!).bold(phoneNumber!, with: UIFont.fontWithTextStyle(textStyle: .subHead))
            lblTitle.attributedText = formattedString
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
