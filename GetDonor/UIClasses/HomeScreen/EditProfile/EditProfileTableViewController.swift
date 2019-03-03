//
//  EditProfileTableViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import AccountKit

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
    @IBOutlet weak var stateBgView: UIView!
    @IBOutlet weak var cityBgView: UIView!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    var profileImage: UIImage!
    var pickerView: UIPickerView!
    
    let viewModel = ProfileViewModel()
    let cscViewModel = CSCViewModel()
    
    var userId: String!
    var datePickerView: UIDatePicker!
    var selectedTxtField = UITextField()
    let toolBar = UIToolbar()
    var _accountKit: AKFAccountKit!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader(onViewController: self)
        tableView.isScrollEnabled = false
        setUpUI()
        tableView.layer.cornerRadius = 10
        //tableView.alpha = 0
        initilizeToolBar()
        loadUserDetails()
        addTapGesture()
        validateCSCTextFields()
    }
    
    func validateCSCTextFields() {
        
        if (txtState.text?.isEmpty)! {
            txtCity.isEnabled = false
            cityBgView.backgroundColor = .lightGray
        }else{
            txtCity.isEnabled = true
            cityBgView.backgroundColor = .white
        }
        if (txtCountry.text?.isEmpty)! {
            txtState.isEnabled = false
            stateBgView.backgroundColor = .lightGray
        }else{
            txtState.isEnabled = true
            stateBgView.backgroundColor = .white
        }

    }
    
    func getCountryList(cscType: CSCListingType, id: String) {
        cscViewModel.loadCSCList(with: cscType, and: id) { [weak self](result) in
            switch result{
            case .Success:
                self?.pickerView.reloadAllComponents()
                self?.loadPickerView()
            case .failure(let msg):
                print(msg)
            }
        }
    }
    
    func setUpUI()  {
        lblFirstName.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtFirstName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblLastName.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtLastName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblMobile.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtMobile.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblEmail.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblBloodGroup.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtBloodGroup.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblCountry.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtCountry.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblCity.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtCity.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblDOB.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtDOB.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        lblState.font = UIFont.fontWithTextStyle(textStyle: .title2_bold)
        txtState.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        btnUpdate.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .headline)
        btnUpdate.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnUpdate.backgroundColor = UIColor.colorFor(component: .button)
        btnUpdate.tintColor = UIColor.white
        
    }
    
    func loadPickerView() {
        
        removeLoader(form: self.pickerView)
        let values = cscViewModel.dataToPopulate.sorted(by: <)
        
        if (selectedTxtField.text?.count)! > 0 {
            if let index = values.index(of: selectedTxtField.text!){
                selectedTxtField.text = values[index]
                self.pickerView.delegate?.pickerView!(self.pickerView, didSelectRow: index, inComponent: 0)
                self.pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            
        }else{
            selectedTxtField.text = values[0]
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            
        }
        
        validateCSCTextFields()
        
    }
    
    func initilizeToolBar() {
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.colorFor(component: .button)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerViewDonePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
    }
    
    func loadUserDetails() {
        
        guard let userId = self.userId else {
            return
        }
        viewModel.getProfile(for: userId, action: .get) { [weak self](result) in
            self?.tableView.isScrollEnabled = true
            self?.removeLoader(fromViewController: self!)
            switch (result){
            case .Success:
                print("Success")
                //self?.tableView.alpha = 1
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
        
        if let dateString = txtDOB.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd"

            if let date = dateFormatter.date(from: dateString){
                datePickerView.date = date
            }
            
        }
        
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
        if selectedTxtField == txtCountry {
            cscViewModel.selectedCountry = txtCountry.text!
        }
        if selectedTxtField == txtState {
            cscViewModel.selectedState = txtState.text!
        }
        
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
        txtState.text = viewModel.model.user?.state
        txtCountry.text = viewModel.model.user?.country
        txtDOB.text = viewModel.model.user?.dob
        if let bloodGroup = viewModel.model.user?.b_group {
            txtBloodGroup.text = bloodGroup.getBloodGroup()
        }
        
        if let vc = self.parent as? EditProfileViewController{
            //vc.imgProfile.loadImage(from: viewModel.model.user?.image, shouldCache: false)
            if let imageUrl = viewModel.model.user?.image {
                vc.imgProfile.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
            }

        }
        loadDatePicker()
        validateCSCTextFields()

    }
    
    @IBAction func actionMobileButtonPressed(_ sender: UIButton) {
        
       
        if _accountKit == nil {
            _accountKit = AKFAccountKit(responseType: .accessToken)
        }
        
        _accountKit.logOut()
        
        if _accountKit?.currentAccessToken != nil {
            print("Already Logged in.")
        }
        else {
            loginWithPhone()
        }
        
    }
    
    func loginWithPhone(){
        let inputState = UUID().uuidString
        let vc = (_accountKit?.viewControllerForPhoneLogin(with: nil, state: inputState))!
        vc.enableSendToFacebook = true
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc as UIViewController, animated: true, completion: nil)
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        loginViewController.delegate = self
        //UI Theming - Optional
        loginViewController.uiManager = AKFSkinManager(skinType: .classic, primaryColor: UIColor.blue)
    }
    
    func getUserInfo() {
        
        if _accountKit == nil {
            
            _accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
            _accountKit.requestAccount { [weak self](account, error) in
                
                if let accountID = account?.accountID{
                    print("AccountID:\(accountID)")
                }
                
                if let email = account?.emailAddress{
                    print("Email:\(email)")
                }
                
                if let phoneNumber = account?.phoneNumber{
                    print("PhoneNumber:\(phoneNumber.phoneNumber)")
                    
                    DispatchQueue.main.async {
                        self?.txtMobile.text = phoneNumber.phoneNumber
                        self?.txtEmail.becomeFirstResponder()
                    }
                }
            }
            
        }else
        {
            _accountKit.requestAccount { [weak self](account, error) in
                
                if let accountID = account?.accountID{
                    print("AccountID:\(accountID)")
                }
                
                if let email = account?.emailAddress{
                    print("Email:\(email)")
                }
                
                if let phoneNumber = account?.phoneNumber{
                    print("PhoneNumber:\(phoneNumber.phoneNumber)")
                    DispatchQueue.main.async {
                        self?.txtMobile.text = phoneNumber.phoneNumber
                        
                    }
                    
                }
            }
        }
    }

    
    @IBAction func actionUpdate(_ sender: UIButton) {
        
        if doValidation() {
            self.btnUpdate.loadingIndicator(show: true)
            let userDetails : [String:Any] = ["phone": txtMobile.text!,
                                              "firstname":txtFirstName.text!,
                                              "lastname":txtLastName.text!,
                                              "city":txtCity.text!,
                                              "country":txtCountry.text!,
                                              "state":txtState.text!,
                                              "b_group":bloodGroups[txtBloodGroup.text!] ?? "",
                                              "dob":txtDOB.text!,
                                              "image": profileImage
            ]
            
            viewModel.updateUserProfile(for: GetDonorUserDefault.sharedInstance.getUserId(), action: .set, userDetails: userDetails) { [weak self](result) in
                self?.btnUpdate.loadingIndicator(show: false)
                switch result{
                case .Success:
                    print("Success")
                    NotificationCenter.default.post(name: .profileUpdated, object: nil)
                    //self?.populateData()
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
extension EditProfileTableViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        cscViewModel.dataToPopulate = []
        selectedTxtField = textField
        self.pickerView  = UIPickerView()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
        self.addLoaderView(to: self.pickerView)
        
        if textField == txtCountry {
            if cscViewModel.shouldMakeCallToFetchCSCListing(for: .country, and: self.txtCountry.text!) {
                getCountryList(cscType: .country, id: "")
            }else{
                loadPickerView()
                pickerView.reloadAllComponents()
            }
        }
        
        if textField == txtState {
            if (txtCountry.text?.isEmpty)!{
                return
            }
            if cscViewModel.shouldMakeCallToFetchCSCListing(for: .state, and: txtState.text!) {
                    getCountryList(cscType: .state, id: txtCountry.text!)
            }else{
                loadPickerView()
                pickerView.reloadAllComponents()
            }
            
        }
        
        if textField == txtCity {
           print(txtCountry.text)
            print(txtState.text)

            if (txtCountry.text?.isEmpty)! || (txtState.text?.isEmpty)!{
                return
            }
            if cscViewModel.shouldMakeCallToFetchCSCListing(for: .city, and: txtState.text!) {
                    getCountryList(cscType: .city, id: txtState.text!)
                
            }else{
                loadPickerView()
                pickerView.reloadAllComponents()
            }
            
        }
    }
}

extension EditProfileTableViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.cscViewModel.dataToPopulate.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let values = self.cscViewModel.dataToPopulate.sorted(by: <)
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let values = self.cscViewModel.dataToPopulate.sorted(by: <)

        if values.count > 0 && values.count >= row {
            selectedTxtField.text = values[row]
            
            if selectedTxtField == txtCountry{
                txtState.isEnabled = true
                stateBgView.backgroundColor = .white

            }
            if selectedTxtField == txtState{
                txtCity.isEnabled = true
                cityBgView.backgroundColor = .white

            }
        }
    }
    
}

extension EditProfileTableViewController {
    
    func addLoaderView(to someView: UIView) {
        let bgView = UIView(frame: CGRect(x: 0, y: (self.pickerView.bounds.height - 50) / 2, width: UIScreen.main.bounds.width, height: 50))
        let activityIndi = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndi.frame = bgView.bounds
        bgView.addSubview(activityIndi)
        activityIndi.startAnimating()
        bgView.backgroundColor = .clear
        bgView.tag = 1001
        someView.addSubview(bgView)
    }
    
    func removeLoader(form someView: UIView) {
        if let viewWithTag = someView.viewWithTag(1001) {
            viewWithTag.removeFromSuperview()
        }
    }
    
}

extension EditProfileTableViewController: AKFViewControllerDelegate{
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print(state)
        getUserInfo()
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print(state)
        
    }
    
}









