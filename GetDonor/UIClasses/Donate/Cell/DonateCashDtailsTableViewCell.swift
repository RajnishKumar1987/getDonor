//
//  DonateCashDtailsTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonateCashDtailsTableViewCell: UITableViewCell,CellReusable {
    @IBOutlet weak var lblCashDetails: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(offset: CGSize.init(width: 0, height: -1), color: UIColor.black, radius: 3.0, opacity: 0.25)
        lblCashDetails.font = UIFont.fontWithTextStyle(textStyle: .regular)
    }

    func configureCell(with model: DonateTableViewCellModel?) {
        if let model = model as? DonateCashDetailsCellViewModel {
            let phoneNumber = model.info?.components(separatedBy: CharacterSet.decimalDigits.inverted).last
            let stringWithoutNumber = model.info?.components(separatedBy: CharacterSet.decimalDigits).joined()
            let formattedString = NSMutableAttributedString()
            formattedString.normal(stringWithoutNumber!).bold(phoneNumber!, with: UIFont.fontWithTextStyle(textStyle: .subHead))
            lblCashDetails.attributedText = formattedString
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
