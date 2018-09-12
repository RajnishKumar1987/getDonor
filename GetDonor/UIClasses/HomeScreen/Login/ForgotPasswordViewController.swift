//
//  ForgotPasswordViewController.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
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


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actionBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
