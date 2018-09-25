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
