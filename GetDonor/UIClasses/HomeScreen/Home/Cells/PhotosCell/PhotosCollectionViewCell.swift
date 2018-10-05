//
//  PhotosCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell,CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    var imageLoader: APIRequestLoader<ImageRequest>?

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "default")
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    override func prepareForReuse() {
        imageView.image = #imageLiteral(resourceName: "default")
        imageLoader = nil
    }

    func configureCell(with model: Photo?) {
        
        
        guard let model = model else { return }
        
        lblTitle.text = model.title ?? ""
        
        if let imageUrl = model.image {
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())

            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imageView.image = image
                }
                
            })
        }
        
    }
    
}
