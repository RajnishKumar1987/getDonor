//
//  VideosCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class VideosCollectionViewCell: UICollectionViewCell,CellReusable {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    var imageLoader: APIRequestLoader<ImageRequest>?

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    
    func configureCell(model: Video) {
        
        lblTitle.text = model.title ?? ""
        //lblDescription.text = model.description ?? ""
        
        guard let imageUrl = model.image else { return }
        
        imageLoader = APIRequestLoader(apiRequest: ImageRequest())
        
        imageLoader?.loadAPIRequest(requestData: imageUrl, completionHandler: { [weak self](image, error) in
            
            if let image = image{
                self?.imageView.image = image
            }
            
            
        })
        
        
    }
}
