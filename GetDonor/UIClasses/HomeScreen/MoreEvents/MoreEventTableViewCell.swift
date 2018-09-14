//
//  MoreEventTableViewCell.swift
//  GetDonor
//
//  Created by admin on 10/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreEventTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var imageLoader: APIRequestLoader<ImageRequest>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        imageLoader = nil
    }

    
    func configureCell(with model: Event?) {
        
        if let model = model {
            lblTitle.text = model.title
            
            guard let imageUrl = model.image else {return}
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            imageLoader.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil) { [weak self](image, error) in
                
                if let image = image{
                    self?.imgView.image = image
                }
                
            }
            
            
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionShareButtonPressed(_ sender: UIButton) {
        
    }
    
}
