//
//  PhotoDetailsViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 04/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var photos : [ContentDataModel]?
    var selectedIndexPath: IndexPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.layoutIfNeeded()
        collectionView.layoutSubviews()
        
        if let indexPath = selectedIndexPath {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)

        }
        
    }
    
    @IBAction func actionCancelButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
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

extension PhotoDetailsViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoDetailsCollectionViewCell = collectionView.dequeueCell(atIndexPath: indexPath)
        let model = photos![indexPath.row]
        cell.configureCell(with: model.image)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
