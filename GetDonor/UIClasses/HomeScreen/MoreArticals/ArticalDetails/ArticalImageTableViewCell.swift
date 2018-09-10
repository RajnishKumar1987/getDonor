//
//  ArticalImageTableViewCell.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ArticalImageTableViewCell: UITableViewCell, CellReusable {
    @IBOutlet weak var imgView: UIImageView!
    
    var imageLoader: APIRequestLoader<ImageRequest>?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(image imageUrl: String?) {
        
        if let imageUrl = imageUrl {
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imgView.image = image
                }
                
            })
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
