//
//  ArticalImageTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ArticalImageTableViewCell: UITableViewCell, CellReusable {
    @IBOutlet weak var imgView: UIImageView!
    
    var imageLoader: APIRequestLoader<ImageRequest>?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.image = #imageLiteral(resourceName: "default")
    }
    override func prepareForReuse() {
        imgView.image = #imageLiteral(resourceName: "default")
        imageLoader = nil
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
