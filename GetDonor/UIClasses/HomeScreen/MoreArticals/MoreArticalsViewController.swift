//
//  MoreArticalsViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreArticalsViewController: BaseViewController {

    var viewModel = ArticalsViewModel()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articals"
        tableView.alpha = 0
        // Do any additional setup after loading the view.
        doInitialConfig()
    }

    func doInitialConfig()  {
        loadArticals()
    }
    
    func loadArticals() {
        
        viewModel.loadArticals { [weak self](result) in
            self?.activityIndicator.stopAnimating()
            switch (result){
            case .Success:
                self?.tableView.alpha = 1
                self?.tableView.reloadData()
                print("Success")
            case .failure(let msg):
                print(msg)
            }
        }
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? ArticalsTableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            if let  articalDeatilsVC = segue.destination as? ArticalDetailsViewController{
                
                articalDeatilsVC.loadArticlsWith(model: self.viewModel.model.articalList!, withSelected: indexPath)
            }
            
        }
    }
    

}

extension MoreArticalsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.model.articalList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell: ArticalsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
        
    }
    
}





