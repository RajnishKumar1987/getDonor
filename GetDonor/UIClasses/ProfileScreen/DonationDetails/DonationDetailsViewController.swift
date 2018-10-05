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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideProfileButton()
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
        viewModel.loadDonationDetails(for: type) { (result) in
            self.removeLoader(fromViewController: self)
            switch result{
            case .Success:
                print("success")
            case .failure(let msg):
                print(msg)
            }
            
        }
    }
    @IBAction func actionSegmentButtonPressed(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("0")
            
        case 1:
            print("1")
        default:
            print("known")
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
