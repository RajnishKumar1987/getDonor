//
//  SimilarVideosTableViewCell.swift
//  GetDonor
//
//  Created by admin on 06/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class SimilarVideosTableViewCell: UITableViewCell,CellReusable {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var imageLoader: APIRequestLoader<ImageRequest>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    
    func configCell(with model:Video)  {
        
        lblTitle.text = model.title ?? ""
        
        if let imageUrl = model.image {
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            imageLoader?.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil, completionHandler: { [weak self](image, error) in
                
                if let image = image{
                    self?.imgView.image = image
                }
                
            })        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
