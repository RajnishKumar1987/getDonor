//
//  SeeAllVideosViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class MoreVideosViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = MoreVideosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Videos"
        
        doInitialConfig()
    }
    
    func doInitialConfig() {
        loadVideos()
    }
    
    func loadVideos() {
        
        viewModel.loadMoreVideos { [weak self] (result) in
            
            switch (result){
            case .Success:
                self?.tableView.reloadData()
                print("Success")
            case .failure(let messgae):
                print(messgae)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? MoreVideosTableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            let videoModel = viewModel.getModelForCell(at: indexPath)
            
            let videoDetailsVC = segue.destination as? VideoDetailsViewController
            
            videoDetailsVC?.model = videoModel
            
            
        }
    }
    

}

extension MoreVideosViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.model.vidoeList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreVideosTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
        
    }
}








