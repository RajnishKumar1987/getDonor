//
//  NoInternetView.swift
//  GetDonor
//
//  Created by admin on 15/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class NoInternetView: UIView {
    @IBOutlet weak var lblWhoops: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    var targetVc: UIViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblWhoops.font = UIFont.fontWithTextStyle(textStyle: .headline)
        lblMessage.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnRetry.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .headline)
        btnRetry.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnRetry.backgroundColor = UIColor.colorFor(component: .button)
        btnRetry.tintColor = UIColor.white

    }

    @IBAction func actionRetry(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.retry.value = targetVc
    }
}
