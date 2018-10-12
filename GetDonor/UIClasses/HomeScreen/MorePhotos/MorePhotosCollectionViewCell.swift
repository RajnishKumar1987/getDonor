//
//  MorePhotosCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MorePhotosCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    var imageLoader: APIRequestLoader<ImageRequest>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "default")
        lblName.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    
    override func prepareForReuse() {
        imageView.image = #imageLiteral(resourceName: "default")
        imageLoader = nil
    }
    
    func configureCell(with model: ContentDataModel?) {
        
        if let model = model {
            
            lblName.text = model.title
        }
        
        if let imageUrl = model?.image {
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imageView.image = image
                }
                
            })
        }
    }
    
}
