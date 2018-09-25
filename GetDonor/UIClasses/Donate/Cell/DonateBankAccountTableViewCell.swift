//
//  DonateBankAccountTableViewCell.swift
//  GetDonor
//
//  Created by admin on 18/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonateBankAccountTableViewCell: UITableViewCell,CellReusable {
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccNumbe: UILabel!
    @IBOutlet weak var lblIFSC: UILabel!

    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var accNumbe: UILabel!
    @IBOutlet weak var iFSC: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(offset: CGSize.init(width: 0, height: -1), color: UIColor.black, radius: 3.0, opacity: 0.25)
        lblInfo.font = UIFont.fontWithTextStyle(textStyle: .regular)
        lblAccountName.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        lblAccountName.adjustsFontSizeToFitWidth = true
        lblBankName.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        lblBankName.adjustsFontSizeToFitWidth = true
        lblAccNumbe.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        lblIFSC.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        accountName.font = UIFont.fontWithTextStyle(textStyle: .regular)
        accountName.adjustsFontSizeToFitWidth = true
        bankName.font = UIFont.fontWithTextStyle(textStyle: .regular)
        bankName.adjustsFontSizeToFitWidth = true
        accNumbe.font = UIFont.fontWithTextStyle(textStyle: .regular)
        accNumbe.adjustsFontSizeToFitWidth = true
        iFSC.font = UIFont.fontWithTextStyle(textStyle: .regular)
        iFSC.adjustsFontSizeToFitWidth = true


    }

    func configureCell(with model: DonateTableViewCellModel?)  {
        if let model = model as? DonateBankDetailsCellViewModel {
            accountName.text = model.accountName
            bankName.text = model.bankName
            accNumbe.text = model.accountNumber
            iFSC.text = model.ifscCode
            lblInfo.text = model.info
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
