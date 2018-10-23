//
//  TopBannerView.swift
//  GetDonor
//
//  Created by Rajnish kumar on 09/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class CarouselView: UIView {

    weak var delegate: CarouselTableViewCellDelegate?
    var itemIndex: Int = 0
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        let nibView = Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)?.first as! UIView
        nibView.frame = self.bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(nibView)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if (delegate != nil) {
            delegate?.didButtonPressed(at: itemIndex)
        }
    }


}
