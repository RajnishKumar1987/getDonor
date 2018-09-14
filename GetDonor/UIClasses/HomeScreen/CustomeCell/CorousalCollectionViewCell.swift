//
//  CorousalCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 28/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class CorousalCollectionViewCell: UICollectionViewCell,CellReusable {

    @IBOutlet weak var imageView: UIImageView!
    var imageLoader: APIRequestLoader<ImageRequest>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        imageLoader = nil
    }

    func configureCell(with imageUrl: String?) {
        
        guard let urlString = imageUrl else { return }
        
        imageLoader = APIRequestLoader(apiRequest: ImageRequest())
        imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: urlString), requestData: nil, completionHandler: { [weak self](image, error) in
            
            if let image = image{
                self?.imageView.image = image
            }
            
        })
    }

}
