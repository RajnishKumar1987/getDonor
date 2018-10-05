//
//  SerachDonorTableViewCell.swift
//  GetDonor
//
//  Created by admin on 27/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class SearchDonorTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    var imageLoader: APIRequestLoader<ImageRequest>!
    var phone: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfile.image = #imageLiteral(resourceName: "default")
        imgProfile.makeCornerRadiusWithValue(imgProfile.frame.width/2)
        imgProfile.layer.borderWidth = 1
        imgProfile.layer.borderColor = UIColor.red.cgColor
        
        lblName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblAddress.font = UIFont.fontWithTextStyle(textStyle: .caption1)
        
        lblName.adjustsFontSizeToFitWidth = true
        lblAddress.adjustsFontSizeToFitWidth = true
    }
    override func prepareForReuse() {
        imgProfile.image = #imageLiteral(resourceName: "default")
        imageLoader = nil
    }
    func configureCell(with model: Doner) {
        
        self.phone = model.phone
        let firstName = model.firstname ?? ""
        let lastName = model.lastname ?? ""
        
        lblName.text = "\(firstName) \(lastName)"
        
        let city = model.city ?? ""
        let state = model.address ?? ""
        let country = model.country ?? ""
        
        
        lblAddress.text = "\(city), \(state), \(country)"
        
        if let imageUrl = model.image{
            
            imageLoader = APIRequestLoader(apiRequest: ImageRequest())
            imageLoader.loadAPIRequest(forFuncion: .getImage(urlString: imageUrl), requestData: nil) { [weak self](image, error) in
                
                if let image = image {
                self?.imgProfile.image = image
                }
            }
        }
    }

    @IBAction func actionCallButtonPressed(_ sender: UIButton) {
        
        guard let phoneNumber = self.phone else { return }
        
        UIApplication.shared.open(URL(string: "telprompt://\(phoneNumber)")!, options: [:]) { (value) in
            }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
