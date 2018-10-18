//
//  ForgotPasswordViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblForgotPass: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblForgotPass.font = UIFont.fontWithTextStyle(textStyle: .extraBold)
        btnSignUp.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .headline)
        btnSignUp.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnSignUp.backgroundColor = UIColor.colorFor(component: .button)
        btnSignUp.tintColor = UIColor.white
        
        txtEmail.font = UIFont.fontWithTextStyle(textStyle: .title1)
        addTapGesture()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actionBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionSubmit(_ sender: Any) {
        
        if doValidation() {
            btnSignUp.loadingIndicator(show: true)
            let apiLoader = APIRequestLoader(apiRequest: CommonApiRequest())
            apiLoader.loadAPIRequest(forFuncion: .forgotPassword(userEmail: txtEmail.text!), requestData: nil) { [weak self] (response, error) in
                self?.btnSignUp.loadingIndicator(show: false)
                let alert = UIAlertController(title: "Please check your mail box.", message: "Password sent to your registred email.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: { (action) in
                    self?.dismiss(animated: true, completion: nil)
                }))
                self?.present(alert, animated: true, completion: nil)

            }
        }
    }
    
    func doValidation() -> Bool {
        
        if txtEmail.text?.isEmpty ?? true {
            showAlert(with: "Email can't be empty.")
            return false
        }
        if !(txtEmail.text?.isValidEmail())! {
            showAlert(with: "Please enter a valid email.")
            return false
        }
        return true
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
