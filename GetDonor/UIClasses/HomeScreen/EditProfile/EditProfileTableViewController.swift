//
//  EditProfileTableViewController.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerDelegate: class{
    func didProfileImageSelected(image: UIImage)
}

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
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var txtState: UITextField!

    @IBOutlet weak var btnUpdate: UIButton!
    
    var profileImage: UIImage!
    
    let viewModel = ProfileViewModel()
    let cscViewModel = CSCViewModel()
    
    var userId: String!
    var datePickerView: UIDatePicker!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tableView.layer.cornerRadius = 10
        tableView.alpha = 0
        loadUserDetails()
        loadDatePicker()
        addTapGesture()
        getCountryList()
    }
    
    func getCountryList() {
        cscViewModel.loadCountryList()
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

        lblCountry.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtCountry.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblCity.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtCity.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblDOB.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtDOB.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtState.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtState.font = UIFont.fontWithTextStyle(textStyle: .title1)

        btnUpdate.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .headline)
        btnUpdate.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnUpdate.backgroundColor = UIColor.colorFor(component: .button)
        btnUpdate.tintColor = UIColor.white

    }
    
    func loadUserDetails() {
        viewModel.getProfile(for: userId, action: .get, userDetails: nil) { [weak self](result) in
            
            
            switch (result){
            case .Success:
                print("Success")
                self?.tableView.alpha = 1
                self?.populateData()
            case .failure(let msg):
                print(msg)
            }
        }
    }
    
    func loadDatePicker() {
        datePickerView  = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.maximumDate = Date(timeIntervalSinceNow: 0)

        datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        txtDOB.inputView = datePickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.colorFor(component: .button)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerViewDonePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtDOB.inputAccessoryView = toolBar
        
    }
    @objc func pickerViewDonePressed()  {
        self.view.endEditing(true)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        txtDOB.text = sender.date.getDateString(format: "yyyy-MM-dd")
    }

    func populateData() {
        txtFirstName.text = viewModel.model.user?.firstname
        txtLastName.text = viewModel.model.user?.lastname
        txtEmail.text = viewModel.model.user?.email
        txtMobile.text = viewModel.model.user?.phone
        txtCity.text = viewModel.model.user?.city
        txtCountry.text = viewModel.model.user?.country
        txtDOB.text = viewModel.model.user?.dob
        if let bloodGroup = viewModel.model.user?.b_group {
            txtBloodGroup.text = bloodGroup.getBloodGroup()
        }
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        
    if doValidation() {
            
        let userDetails : [String:Any] = ["phone": txtMobile.text!,
                               "firstname":txtFirstName.text!,
                               "lastname":txtLastName.text!,
                               "city":txtCity.text!,
                               "country":txtCountry.text!,
                               "b_group":"6",
                               "dob":txtDOB.text!,
                              "image": profileImage
                               ]
            
            viewModel.updateUserProfile(for: AppConfig.getUserId(), action: .set, userDetails: userDetails) { [weak self](result) in
                switch result{
                case .Success:
                    print("Success")
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let msg):
                    print(msg)
                }
            }
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
        if txtDOB.text?.isEmpty ?? true {
            showMessage(with: "DOB can't be empty.")
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

extension EditProfileTableViewController: EditProfileViewControllerDelegate{
    func didProfileImageSelected(image: UIImage) {
        self.profileImage = image
    }
}
