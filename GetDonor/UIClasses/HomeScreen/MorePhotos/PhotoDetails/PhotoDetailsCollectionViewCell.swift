//
//  PhotoDetailsCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoDetailsCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    var imageLoader : APIRequestLoader<ImageRequest>?
    
    func configureCell(with imageUrl: String?) {
     
        if let imageUrl = imageUrl {
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imageView.image = image
                }
                
            })
            
        }
    }
    
}
