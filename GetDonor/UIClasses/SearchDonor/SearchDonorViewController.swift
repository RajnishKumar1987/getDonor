//
//  SearchDonorViewController.swift
//  GetDonor
//
//  Created by admin on 13/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class SearchDonorViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtBloodGroup: UITextField!
    var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Donor"
        btnSearch.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnSearch.makeCornerRadiusWithValue(15.0, borderColor: nil)
        btnSearch.backgroundColor = UIColor.colorFor(component: .button)
        btnSearch.tintColor = UIColor.white
        lblNote.font = UIFont.fontWithTextStyle(textStyle: .title2)
        lblDesc.font = UIFont.fontWithTextStyle(textStyle: .title3)
        txtBloodGroup.font = UIFont.fontWithTextStyle(textStyle: .title1)
        
    }
    
    func searchDonor() {
        if doValidation() {
            self.performSegue(withIdentifier: "openSearchView", sender: nil)
            }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openSearchView" {
            let searchResultVC = segue.destination as! SearchResultViewController
            searchResultVC.bloodGroup = bloodGroups[txtBloodGroup.text!]
        }
    }
    
    
    func doValidation() -> Bool {
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


    @IBAction func actionSearchButtonPressed(_ sender: UIButton) {
        searchDonor()
    }
    
    func loadPickerView() {
        pickerView  = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        txtBloodGroup.inputView = pickerView
        txtBloodGroup.text = bloodGroupsArray[0]
        
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
        self.pickerView.delegate?.pickerView!(self.pickerView, didSelectRow: 0, inComponent: 0)
    }

    @objc func pickerViewDonePressed() {
        self.pickerView.removeFromSuperview()
        self.txtBloodGroup.resignFirstResponder()
    }

}

extension SearchDonorViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return bloodGroupsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodGroupsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        txtBloodGroup.text = bloodGroupsArray[row]
    }
    
}

extension SearchDonorViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBloodGroup {
            loadPickerView()
        }
    }
}
