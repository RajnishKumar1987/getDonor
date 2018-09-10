//
//  MorePhotosHeaderCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 05/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MorePhotosHeaderCollectionViewCell: UICollectionViewCell, CellReusable {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .body)
        lblTitle.text = "Any donor can upload their images while donating blood directly in GetDonor app. just email us at: - upload@getdonoor.org"
    }
}
