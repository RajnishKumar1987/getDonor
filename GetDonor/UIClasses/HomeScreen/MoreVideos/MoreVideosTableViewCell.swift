//
//  MoreVideosTableViewCell.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreVideosTableViewCell: UITableViewCell, CellReusable{

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var imageLoader: APIRequestLoader<ImageRequest>?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
    }
    
    func configureCell(with model: Video?) {
        
        lblTitle.text = model?.title
        
        if let imageUrl = model?.image {
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
                        
            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: [:], completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imgView.image = image
                }
                
            })
            
        }
        
    }


}
