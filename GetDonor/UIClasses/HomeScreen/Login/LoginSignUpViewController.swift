//
//  LoginSignUpTableViewController.swift
//  GetDonor
//
//  Created by admin on 05/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UITableViewController {

    @IBOutlet weak var lblWecome: UILabel!
    @IBOutlet weak var lblGetDonor: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    var apiLoader: APIRequestLoader<LoginApiRequest>!

    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "bglogin")
        tableView.backgroundView = imageView
        
        lblWecome.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblGetDonor.font = UIFont.fontWithTextStyle(textStyle: .extraBold)
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtEmail.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title1)
        txtPassword.font = UIFont.fontWithTextStyle(textStyle: .title2)
        txtPassword.makeCornerRadiusWithValue(15.0, borderColor: UIColor.black)
        txtPassword.font = UIFont.fontWithTextStyle(textStyle: .title1)

        btnLogin.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnLogin.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnLogin.backgroundColor = UIColor.colorFor(component: .button)
        btnLogin.tintColor = UIColor.white
        btnSignUp.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnSignUp.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnSignUp.backgroundColor = UIColor.colorFor(component: .button)
        btnSignUp.tintColor = UIColor.white


        btnForgotPassword.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title2)
        btnForgotPassword.tintColor = UIColor.black
        

    }

    @IBAction func actionLogingButtonPressed(_ sender: Any) {
        doLogin()
    }
    @IBAction func actionForgotPasswordButtonPressed(_ sender: UIButton) {
    }
    @IBAction func actionSignUpButtonPressed(_ sender: UIButton) {
    }
    func doLogin() {
        
        
        let loader = APIRequestLoader(apiRequest: CommonApiRequest())
        
        
        loader.loadAPIRequest(forFuncion: .login, requestData: nil) { [weak self](response, error) in
            
            print(response)
            self?.performSegue(withIdentifier: "unwindSegueToHome", sender: nil)
            
        }
        
        
//        self.apiLoader = APIRequestLoader(apiRequest: LoginApiRequest())
//        
//        apiLoader.loadAPIRequest(forFuncion: .login, requestData: <#T##[String : String]?#>, completionHandler: <#T##(LoginDataModel?, Error?) -> Void#>)
        
//        self.loginViewModel.login(with: txtEmail.text!, and: txtPassword.text!) { (result) in
//            
//            switch (result){
//            case .Success:
//                print("Success")
//            case .failure(let msg):
//                print(msg)
//            }
//        }
        
    }
    


}
