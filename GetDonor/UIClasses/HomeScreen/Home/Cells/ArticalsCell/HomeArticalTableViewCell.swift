//
//  HomeArticalTableViewCell.swift
//  GetDonor
//
//  Created by admin on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class HomeArticalTableViewCell: UITableViewCell, CellReusable {
    @IBOutlet weak var lblCellName: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: HomeScreenCellDelegate?
    var articalsModelArray: [ContentDataModel]? = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        lblCellName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnMore.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title2)
    }
    
    func configureCell(with model: [ContentDataModel]?) {
        
        self.articalsModelArray = model
        self.collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionMoreArticalsButtonPressed(_ sender: Any) {
        if (self.delegate != nil){
            self.delegate?.didMoreButtonPressed(at: .artical)
        }
    }
}

extension HomeArticalTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (articalsModelArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ArticalCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configurecell(model: articalsModelArray![indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width - 16, height: self.bounds.size.height - 54)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let delegate = self.delegate else { return }
        delegate.didCellSelected(at: indexPath, with: .artical)
    }
    
}
