//
//  EventsCollectionViewCell.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell,CellReusable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var imageLoader: APIRequestLoader<ImageRequest>?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    
    func configureCell(with model: Event?) {
        
        guard let model = model else { return }
        
        lblTitle.text = model.title ?? ""
        
        if let imageUrl = model.image  {
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            
            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imageView.image = image
                }
                
            })
        }
        
        
    }
}
