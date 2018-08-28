//
//  DesireTableViewCell.swift
//  GetDonor
//
//  Created by admin on 27/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DesireTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var model: DesireCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerLabel.font = UIFont.fontWithTextStyle(textStyle: .title2)
        descLabel.font = UIFont.fontWithTextStyle(textStyle: .title3)

    }
    
    func configureCell(with model: DesireCellViewModel?) {
        
        if let model = model as? HeadeAndDescriptionCellViewModel {
            
            self.headerLabel.text = model.headerText ?? ""
            self.descLabel.text = model.descriptionText ?? ""
        }
    }

    

}
