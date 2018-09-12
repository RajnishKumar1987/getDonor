//
//  EditProfileTableViewController.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UITableViewController {

    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var lblBloodGroup: UILabel!
    @IBOutlet weak var txtBloodGroup: UITextField!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtCountry: UITextField!

    @IBOutlet weak var btnUpdate: UIButton!
    
    let viewModel = ProfileViewModel()
    var userId: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tableView.layer.cornerRadius = 10
        loadUserDetails()
    }
    
    func setUpUI()  {
        lblFirstName.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtFirstName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblLastName.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtLastName.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblMobile.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtMobile.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblEmail.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblBloodGroup.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtBloodGroup.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblAddress.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtAddress.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblCountry.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtCountry.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblCity.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtCity.font = UIFont.fontWithTextStyle(textStyle: .title1)

        btnUpdate.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .headline)
        btnUpdate.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnUpdate.backgroundColor = UIColor.colorFor(component: .button)
        btnUpdate.tintColor = UIColor.white

    }
    
    func loadUserDetails() {
        viewModel.userProfile(for: userId, action: .get, userDetails: nil) { [weak self](result) in
            switch (result){
            case .Success:
                print("Success")
                self?.populateData()
            case .failure(let msg):
                print(msg)
            }
        }
    }

    func populateData() {
        txtFirstName.text = viewModel.model.user?.firstname
        txtLastName.text = viewModel.model.user?.lastname
        txtEmail.text = viewModel.model.user?.email
        txtMobile.text = viewModel.model.user?.phone
        txtCity.text = viewModel.model.user?.city
        txtCountry.text = viewModel.model.user?.country
        txtAddress.text = viewModel.model.user?.address
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        
        if doValidation() {
            
            let param = [""]
            
        }
        
    }
    
    func doValidation() -> Bool {
        
        if txtEmail.text?.isEmpty ?? true {
            showMessage(with: "Email can't be empty.")
            return false
        }
        if !(txtEmail.text?.isValidEmail())! {
            showMessage(with: "Please enter a valid email.")
            return false
        }
        if txtFirstName.text?.isEmpty ?? true {
            showMessage(with: "First name can't be empty.")
            return false
        }
        if txtLastName.text?.isEmpty ?? true {
            showMessage(with: "Last name can't be empty.")
            return false
        }
        if txtBloodGroup.text?.isEmpty ?? true {
            showMessage(with: "Please select blood group.")
            return false
        }
        return true
    }
    
    func showMessage(with title:String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
