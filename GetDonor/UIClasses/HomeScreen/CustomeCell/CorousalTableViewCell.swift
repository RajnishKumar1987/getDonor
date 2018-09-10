//
//  CorousalTableViewCell.swift
//  GetDonor
//
//  Created by admin on 27/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class CorousalTableViewCell: UITableViewCell,CellReusable {
    
    var model: CorousalCellViewModel?
    var timer: Timer!
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerReusableCell(CorousalCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(animateCollectionView), userInfo: nil, repeats: true)
        
    }
    
    @objc func animateCollectionView() {
        collectionView.scrollToNextItem()
    }
    
    func configureCell(with model:DesireCellViewModel?) {
        
        if let model = model as? CorousalCellViewModel {
            
            self.model = model
            self.pageControl.numberOfPages = (model.imagePathArray?.count)!
            collectionView.reloadData()

        }
    }

}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        
        UIView.animate(withDuration: 2) {
            self.moveToFrame(contentOffset: contentOffset)

        }
    }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: self.contentOffset.y , width: self.frame.width, height: self.frame.height)
        self.scrollRectToVisible(frame, animated: true)
    }
}

extension CorousalTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.imagePathArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CorousalCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: model?.imagePathArray![indexPath.row])
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width - 16, height: self.bounds.size.height - 35)
    }

}
