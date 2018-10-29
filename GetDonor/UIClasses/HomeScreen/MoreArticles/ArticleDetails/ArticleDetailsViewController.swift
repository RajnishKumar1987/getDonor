//
//  ArticleDetailsViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: BaseViewController {

    var articles: [ContentDataModel]?
    var selectedIndex: IndexPath?
    var selectedModel: ContentDataModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Article Details"
        configureNavigationBarButton(buttonType: .share)
        
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        
        if let indexPath = selectedIndex {
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func presentActivityViewController() {
        let model = ShareDataModel(title: selectedModel.title, image: selectedModel.image, shareURL: selectedModel.s_url)
        showShareActivity(model: model)
    }
    
    func loadArticlsWith(model:[ContentDataModel],withSelected indexPath: IndexPath) {
        self.articles = model
        self.selectedIndex = indexPath
        //self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ArticleDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (articles?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ArticleDetailsCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: articles?[indexPath.item])
        //cell.parentVC = self
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height - ( self.navigationController!.navigationBar.frame.size.height + self.tabBarController!.tabBar.frame.size.height) + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        selectedModel = articles?[indexPath.item]
    }

    
}
