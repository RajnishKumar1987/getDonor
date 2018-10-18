//
//  HomeEventTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class HomeEventTableViewCell: UITableViewCell,CellReusable {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var eventsModelArray: [ContentDataModel]? = []
    weak var delegate: HomeScreenCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnMore.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title2)
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func configureCell(with model: [ContentDataModel]?) {
        
        if let model = model, model.count > 0 {
            eventsModelArray = model
            
            collectionView.reloadData()
        }
    }
    @IBAction func actionMoreEventsButtonPressed(_ sender: UIButton) {
        if (self.delegate != nil) {
            self.delegate?.didMoreButtonPressed(at: .event)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomeEventTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (eventsModelArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: EventsCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: eventsModelArray?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width - 26) / 2, height: self.bounds.size.height - 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        delegate.didCellSelected(at: indexPath, with: .event)

    }

}
