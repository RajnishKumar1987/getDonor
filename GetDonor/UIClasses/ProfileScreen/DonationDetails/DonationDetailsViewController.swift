//
//  DonationDetailsViewController.swift
//  GetDonor
//
//  Created by admin on 05/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class DonationDetailsViewController: BaseViewController {
    @IBOutlet weak var lblWhyDonate: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblUsedEndowment: UILabel!
    @IBOutlet weak var lblUsedValue: UILabel!
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    var viewModel = DonationDetailsViewModel()
    var selectedDonationDetailsType: DonationDetailsType = .allDonations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideProfileButton()
        disableRefresh()
        self.title = "Donation Details"
        doInitialConfig()
    }
    
    func doInitialConfig()  {
        self.lblWhyDonate.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        self.lblAnswer.font = UIFont.fontWithTextStyle(textStyle: .regular)
        lblAnswer.text = "Well, that answer can only come from your heart. Happy Giving!"
        lblTotal.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        lblUsedEndowment.font = UIFont.fontWithTextStyle(textStyle: .subHead)
        lblTotalValue.font = UIFont.fontWithTextStyle(textStyle: .regular)
        lblUsedValue.font = UIFont.fontWithTextStyle(textStyle: .regular)
        lblTotalValue.textColor = UIColor.colorFor(component: .button)
        lblUsedValue.textColor = UIColor.colorFor(component: .button)
        segmentButton.borderColor = UIColor.colorFor(component: .button)
        segmentButton.tintColor = UIColor.colorFor(component: .button)
        segmentButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.fontWithTextStyle(textStyle: .title1)],
                                                for: .normal)
        segmentButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.fontWithTextStyle(textStyle: .title1)],
                                             for: .selected)
        
        
        loadDonationDetails(for: .allDonations)

    }
    
    func loadDonationDetails(for type: DonationDetailsType) {
        showLoader(onViewController: self)
        viewModel.loadDonationDetails(for: type) { [weak self](result) in
            self?.removeLoader(fromViewController: self!)
            switch result{
            case .Success:
                print("success")
                self?.tableview.reloadData()
                self?.updateEndowmentDetails()
            case .failure(let msg):
                print(msg)
            }
            
        }
    }
    
    func updateEndowmentDetails() {
        switch selectedDonationDetailsType {
        case .allDonations:
            if let usedEnd = viewModel.allDonations.usedEndowment{
                self.lblUsedValue.text = "₹ " + usedEnd
            }
            if let totalEnd = viewModel.allDonations.totalEndowmant{
                self.lblTotalValue.text = "₹ " + totalEnd
            }
        case .myDonation:
            if let usedEnd = viewModel.myDonation.usedEndowment{
                self.lblUsedValue.text = "₹ " + usedEnd
            }
            if let totalEnd = viewModel.myDonation.totalEndowmant{
                self.lblTotalValue.text = "₹ " + totalEnd
            }
        }
    }
    @IBAction func actionSegmentButtonPressed(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            selectedDonationDetailsType = .allDonations
            if viewModel.allDonations.transactions.count > 0{
                tableview.reloadData()
                updateEndowmentDetails()
            }
            else
            {
                loadDonationDetails(for: selectedDonationDetailsType)
            }
        case 1:
            selectedDonationDetailsType = .myDonation
            if viewModel.myDonation.transactions.count > 0{
                tableview.reloadData()
                updateEndowmentDetails()
            }
            else
            {
                loadDonationDetails(for: selectedDonationDetailsType)
            }

        default:
            print("known")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebViewController
        vc.urlString = sender as! String
        vc.title = "Receipt"
        
    }
    

}

extension DonationDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCountFor(cellType: selectedDonationDetailsType)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DonationDetailsTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configureCell(with: viewModel.getModelFor(cellType: selectedDonationDetailsType, indexPath: indexPath), forType: selectedDonationDetailsType)
        cell.delegate = self
        return cell
    }
}

extension DonationDetailsViewController: DonationDetailsTableViewCellDelegate{
    func didDownloadFinished() {
        self.tableview.reloadData()
    }
    func didViewReceiptPressed(receiptUrl: String) {
        self.performSegue(withIdentifier: "openWebView", sender: receiptUrl)
    }
}









