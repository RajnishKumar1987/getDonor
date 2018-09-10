//
//  ArticalDetailsViewController.swift
//  GetDonor
//
//  Created by admin on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ArticalDetailsViewController: UIViewController {

    var articals: [Article]?
    var selectedIndex: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        
        if let indexPath = selectedIndex {
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)

        }
    }
    
    func loadArticlsWith(model:[Article],withSelected indexPath: IndexPath) {
        self.articals = model
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

extension ArticalDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (articals?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ArticalDetailsCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: articals?[indexPath.item])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height - ( self.navigationController!.navigationBar.frame.size.height + self.tabBarController!.tabBar.frame.size.height) + 40)
    }

    
}
