//
//  HomeVideoTableViewCell.swift
//  GetDonor
//
//  Created by admin on 23/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//


protocol HomeScreenCellDelegate: class {
    
    func didMoreButtonPressed(at cellType: HomeScreenCellType)
    func didCellSelected(at indexPath: IndexPath, with cellType: HomeScreenCellType)
    func didCellSelected(at index:IndexPath, with model:ContentDataModel)
}

extension HomeScreenCellDelegate{
    
    func didCellSelected(at index:IndexPath, with model:ContentDataModel){

    }
}

protocol HomeVideoTableViewCellDelegate:class {
}

import UIKit


class HomeVideoTableViewCell: UITableViewCell, CellReusable {

    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    weak var delegate : HomeScreenCellDelegate?
    
    var videosModelArray: [ContentDataModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnMore.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title2)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configurecell(model: [ContentDataModel]?) {
        
        if let model = model {
            
            self.pageControl.numberOfPages = model.count
            self.videosModelArray = model
            collectionView.reloadData()

        }
    }

    @IBAction func actionMoreVideosButtonPressed(_ sender: UIButton) {
        
        if (self.delegate != nil) {
            
            self.delegate?.didMoreButtonPressed(at: .video)
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}

extension HomeVideoTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videosModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: VideosCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(model: videosModelArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width - 16, height: self.bounds.size.height - 68)
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (self.delegate != nil) {
            self.delegate?.didCellSelected(at: indexPath, with: .video)
        }
    }
}
