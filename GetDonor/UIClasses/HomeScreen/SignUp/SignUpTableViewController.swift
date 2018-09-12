//
//  SignUpTableViewController.swift
//  GetDonor
//
//  Created by admin on 07/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import AccountKit

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtBloodGroup: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    var pickerView: UIPickerView!
    
    var _accountKit: AKFAccountKit!
    let viewModel = SignUpViewModel()
    
    let bloodGroups = ["O+":"1","O-":"2","A+":"3","A-":"4","B+":"5","B-":"6","AB+":"7","AB-":"8"]
    
    //1=>"O+",2=>"O-",3=>"A+",4=>"A-",5=>"B+",6=>"B-",7=>"AB+",8=>"AB-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMobile.text = "8369150994"
        txtEmail.text = "rajkumar@gmail.com"
        txtFirstName.text = "raj"
        txtLastName.text = "kumar"
        txtPassword.text = "12345"
        txtConfirmPassword.text = "12345"
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "bglogin")
        tableView.backgroundView = imageView
        doInitialConfig()
        configureUI()
    }
    
    func doInitialConfig() {
        
        if _accountKit == nil {
            _accountKit = AKFAccountKit(responseType: .accessToken)
        }
        
        _accountKit.logOut()

    }

    func configureUI() {
        
        lblSignUp.font = UIFont.fontWithTextStyle(textStyle: .extraBold)
        txtEmail.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtMobile.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtMobile.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtFirstName.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtFirstName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtLastName.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtLastName.font = UIFont.fontWithTextStyle(textStyle: .title1)

        txtPassword.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtPassword.font = UIFont.fontWithTextStyle(textStyle: .title1)

        txtConfirmPassword.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtConfirmPassword.font = UIFont.fontWithTextStyle(textStyle: .title1)

        txtBloodGroup.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtBloodGroup.font = UIFont.fontWithTextStyle(textStyle: .title1)

        
        
        btnSignUp.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnSignUp.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnSignUp.backgroundColor = UIColor.colorFor(component: .button)
        btnSignUp.tintColor = UIColor.white

    }
    
    @IBAction func actionMobileButtonPressed(_ sender: UIButton) {
        
        if _accountKit?.currentAccessToken != nil {
            print("Already Logged in.")
        }
        else {
            loginWithPhone()
        }

    }
    @IBAction func actionBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionSignUpButtonPressed(_ sender: UIButton) {
        
        if doValidation() {
            
            let b_group = bloodGroups[txtBloodGroup.text!]
            
            let param : [String:String] = ["email":txtEmail.text!,
                         "password":txtPassword.text!,
                         "phone": txtMobile.text!,
                         "firstname":txtFirstName.text!,
                         "lastname": txtLastName.text!,
                         "version":"1.0.0",
                         "b_group": b_group!
                         ]
            

            viewModel.login(with: param) {[weak self] (result) in
                switch (result){
                case .Success:
                    print("Success")
                case .failure(let msg):
                    self?.performSegue(withIdentifier: "unwindSegueToHome", sender: "openEditProfile")

                    //self?.showError(with: msg)
                }
            }
        }
    }
    
    
    func loginWithPhone(){
        let inputState = UUID().uuidString
        let vc = (_accountKit?.viewControllerForPhoneLogin(with: nil, state: inputState))!
        vc.enableSendToFacebook = true
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc as UIViewController, animated: true, completion: nil)
    }

    func loadPickerView() {
        pickerView  = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        txtBloodGroup.inputView = pickerView
        let bloodGroup = Array(bloodGroups.keys)
        txtBloodGroup.text = bloodGroup[0]
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.colorFor(component: .button)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerViewDonePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtBloodGroup.inputAccessoryView = toolBar

    }
    
    @objc func pickerViewDonePressed() {
        self.view.endEditing(true)
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
                    self?.txtMobile.text = phoneNumber.phoneNumber

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
        if txtPassword.text?.isEmpty ?? true {
            showMessage(with: "Password can't be empty.")
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
        if txtPassword.text != txtConfirmPassword.text {
            showMessage(with: "Your password and confirmation password do not match")
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
    func showError(with title:String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

extension SignUpTableViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return bloodGroups.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let bloodGroup = Array(bloodGroups.keys)
        return bloodGroup[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let bloodGroup = Array(bloodGroups.keys)
        txtBloodGroup.text = bloodGroup[row]
    }

}

extension SignUpTableViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBloodGroup {
            loadPickerView()
        }
    }
}

extension SignUpTableViewController: AKFViewControllerDelegate{
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print(state)
        getUserInfo()
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print(state)
        
    }
    
}

