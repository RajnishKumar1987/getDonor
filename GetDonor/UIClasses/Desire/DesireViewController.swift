//
//  DesireViewController.swift
//  GetDonor
//
//  Created by admin on 24/08/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DesireViewController: BaseViewController {

    var viewModel = DesireViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Desire"
        self.doInitialConfig()
    }
    
    func doInitialConfig() {
    
        showLoader(onViewController: self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell(CorousalTableViewCell.self)
        viewModel.loadDesire { [weak self](result) in
            self?.removeLoader(fromViewController: self!)
            switch result{
            case .Success:
                self?.tableView.reloadData()
                print("success")
            case .failure(let message):
                print(message)

            }
        }
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

extension DesireViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.cellType.count)
        return viewModel.cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = viewModel.cellType[indexPath.row]
    
        switch cellType {
        case .corousal:
            let cell: CorousalTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: cellType))
            return cell
        case .headingAndDescription(let index):
            let cell: DesireTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .headingAndDescription(indexPath: index)))
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = viewModel.cellType[indexPath.row]
        
        switch cellType {
        case .corousal:
            return 250
        default:
            return UITableViewAutomaticDimension
        }

    }
}
