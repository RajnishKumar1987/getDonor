//
//  DonateViewController.swift
//  GetDonor
//
//  Created by admin on 13/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import WebKit
class DonateViewController: BaseViewController {

    var viewModel = DonateViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Donate"
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        loadDonationDetails()
    }
    
    func loadDonationDetails()  {
        viewModel.loadDonationDetails { [weak self](result) in
            switch result{
            case .Success:
                print("success")
                self?.tableView.reloadData()
            case .failure(let msg):
                print(msg)
            }
        }
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

extension DonateViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellTypes[indexPath.row]
        switch cellType {
        case .description:
            let cell : DonateDescTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .description))
            return cell
        case .qa(let index):
            let cell: DonateQ_ATableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .qa(index: index)))
            return cell
        case .secure:
            let cell: DonateSecureTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .secure))
            return cell
        case .upiDetails:
            let cell: DonateUPIDetailsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .upiDetails))
            return cell
        case .bankDetails:
            let cell: DonateBankAccountTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .bankDetails))
            return cell
        case .cashDetails:
            let cell: DonateCashDtailsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
            cell.configureCell(with: viewModel.getModelFor(cell: .cashDetails))
            return cell
        }
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellType = viewModel.cellTypes[indexPath.row]
//        switch cellType {
//        case .bankDetails:
//            return 100
//        default:
//            return UITableViewAutomaticDimension
//        }
//    }
}
