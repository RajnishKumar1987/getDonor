//
//  ArticleDetailsCollectionViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

enum ArticleCellType {
    case title, description, image
}

class ArticleDetailsCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet weak var tableView: UITableView!
    //var model: ContentDataModel?
    let cellTypes : [ArticleCellType] = [.title, .image, .description]
    var viewModel = ArticleDetailsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self

        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepareForReuse() {
        viewModel = ArticleDetailsViewModel()
    }
    
    func configureCell(with model: ContentDataModel?) {
        

        showLoaderOnView(someView: self)
        viewModel.loadArticleDetails(contentId: (model?.id)!) { [weak self](result) in
            self?.removeLoader(fromView: self)
            switch result{
            case .Success:
                self?.tableView.reloadData()
            case .failure(let msg):
                print(msg)
            }
        }
    }
    
}

extension ArticleDetailsCollectionViewCell: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = cellTypes[indexPath.row]
        
        switch cellType {
        case .image:
            let cell: ArticleImageTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCellWith(image: viewModel.model.node?.image)
            return cell
        case .title:
            let cell: ArticleDeatilsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.lblTitle.text = viewModel.model.node?.title
            cell.lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
            cell.lblTitle.textAlignment = .natural
            return cell
        default:
            let cell: ArticleDeatilsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            
            if let attributedString = viewModel.model.node?.description?.htmlToAttributedString{
                cell.lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
                let range = NSRange(location:0,length:1) // specific location. This means "range" handle 1 character at location 2
                attributedString.addAttribute(.font, value: UIFont.fontWithTextStyle(textStyle: .headline), range: range)
                attributedString.addAttribute(.font, value: UIFont.fontWithTextStyle(textStyle: .title2), range: NSRange(location: 1, length: attributedString.string.count - 1))
                cell.lblTitle.attributedText = attributedString
                cell.lblTitle.textColor = UIColor.darkGray
                cell.lblTitle.textAlignment = .justified
            }
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = cellTypes[indexPath.row]
        
        switch cellType {
        case .image:
            return 250
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
