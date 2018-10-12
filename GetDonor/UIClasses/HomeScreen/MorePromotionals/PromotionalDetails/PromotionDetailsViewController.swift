//
//  PromotionDetailsViewController.swift
//  GetDonor
//
//  Created by admin on 09/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PromotionDetailsViewController: BaseViewController {

    var contentId: String!
    var viewModel = PromotionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Promotion Details"
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = UITableViewAutomaticDimension
        loadPromotion()
        showLoader(onViewController: self)
    }
    
    func loadPromotion() {
        viewModel.loadPromotionPage(for: contentId) { [weak self](result) in
            self?.removeLoader(fromViewController: self!)
            switch result{
            case .Success:
                self?.tableview.reloadData()
                print("Success")
            case .failure(let msg):
                print(msg)
            }
        }
    }
    
}

extension PromotionDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellType[indexPath.row]
        switch cellType {
        case .title:
            let cell: PromotionTitleTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.lblTitle.text = viewModel.model.response?.title
            cell.lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
            return cell
        case .image:
            let cell: CarouselTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cellType: .image), and: .topBanner)
            cell.delegate = self
            return cell
        case .description:
            let cell: PromotionTitleTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.lblTitle.text = viewModel.model.response?.extraData?.text
            cell.lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
            cell.lblTitle.textAlignment = .justified
            return cell
        case .vidoes:
            let cell: CarouselTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cellType: .vidoes), and: .topBanner)
            cell.delegate = self
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = viewModel.cellType[indexPath.row]
        
        switch cellType {
        case .description, .title:
            return UITableViewAutomaticDimension
        case .image, .vidoes:
            return kCarouselHeight
        }

    }
}

extension PromotionDetailsViewController : HomeScreenCellDelegate{
    
    func didCellSelected(at index: IndexPath, with model: ContentDataModel) {
        
        if let contentType = ContentType(rawValue: model.type!){
            switch contentType{
            case .video:
                let storyboard = UIStoryboard.init(name: "Videos", bundle: nil)
                let videoDetailsVC = storyboard.instantiateViewController(withIdentifier: "VideoDetailsViewController") as! VideoDetailsViewController
                videoDetailsVC.model = model
                self.navigationController?.pushViewController(videoDetailsVC, animated: true)
            case .photo:
                let storyboard = UIStoryboard.init(name: "PhotoViewer", bundle: nil)
                let photoViewerVc = storyboard.instantiateViewController(withIdentifier: "PhotoViewerViewController") as! PhotoViewerViewController
                photoViewerVc.viewModel = PhotoViewerViewModel(with: viewModel.getModelFor(cellType: .image))
                photoViewerVc.selectedIndex = index
                self.navigationController?.pushViewController(photoViewerVc, animated: true)
            default:
                print("unknown type")
            }
        }
        
        

    }
}





