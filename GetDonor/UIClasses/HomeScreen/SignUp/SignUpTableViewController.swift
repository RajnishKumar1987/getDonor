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
    @IBOutlet weak var btnSignUp: UIButton!
    
    var _accountKit: AKFAccountKit!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        txtMobile.text = "8369150993"
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
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtEmail.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtMobile.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtMobile.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtMobile.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtFirstName.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtFirstName.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtFirstName.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
        txtLastName.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtLastName.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtLastName.font = UIFont.fontWithTextStyle(textStyle: .title1)

        txtPassword.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtPassword.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtPassword.font = UIFont.fontWithTextStyle(textStyle: .title1)

        txtConfirmPassword.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtConfirmPassword.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtConfirmPassword.font = UIFont.fontWithTextStyle(textStyle: .title1)

        
        
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
        
        let apiLoader = APIRequestLoader(apiRequest: SignUpApiRequest())
        
        let param = ["email":txtEmail.text ?? "",
                     "password":txtPassword.text ?? "",
                     "phone": txtMobile.text ?? "",
                     "firstname":txtFirstName.text ?? "",
                     "lastname": txtLastName.text ?? "",
                     ]
        
        
        apiLoader.loadAPIRequest(forFuncion: .registration, requestData: param) {[weak self] (response, error) in
            
            self?.performSegue(withIdentifier: "unwindSegueToHome", sender: self)

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

