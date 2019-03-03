//
//  HomeSocialTableViewCell.swift
//  GetDonor
//
//  Created by admin on 23/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class HomeSocialTableViewCell: UITableViewCell, CellReusable {
    @IBOutlet weak var collectionView: UICollectionView!
    var model: [Social]? = []
    weak var delegate: HomeScreenCellDelegate?
    @IBOutlet weak var lblFollowUs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        lblFollowUs.font = UIFont.fontWithTextStyle(textStyle: .title1_bold)
    }
    
    func configureCell(with model: [Social]?) {
        if let model = model, model.count > 0 {
            self.model = model
            collectionView.frame.size.width = CGFloat((50 * model.count) + 20)
            collectionView.frame.origin.x = (UIScreen.main.bounds.width - collectionView.frame.size.width) / 2
            collectionView.reloadData()
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomeSocialTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeSocialCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        let social = model![indexPath.item]
        if let imageUrl = social.image {
            cell.imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        delegate.didCellSelected(at: indexPath, with: .social)
    }

}
