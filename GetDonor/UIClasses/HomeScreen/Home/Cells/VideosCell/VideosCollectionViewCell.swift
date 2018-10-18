//
//  VideosCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class VideosCollectionViewCell: UICollectionViewCell,CellReusable {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    var imageLoader: APIRequestLoader<ImageRequest>?

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "default")
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    override func prepareForReuse() {
        imageView.image = #imageLiteral(resourceName: "default")
        imageLoader = nil
    }

    func configureCell(model: ContentDataModel) {
        
        lblTitle.text = model.title ?? ""        
        guard let imageUrl = model.image else { return }
        
        imageLoader = APIRequestLoader(apiRequest: ImageRequest())
        
        imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
            
            if let image = image{
                self?.imageView.image = image
            }
            
        })
        
    }
}
