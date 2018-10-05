//
//  EditProfileViewController.swift
//  GetDonor
//
//  Created by admin on 12/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    var imagePicker = UIImagePickerController()
    var userId: String!
    weak var delegate: EditProfileTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideProfileButton()
        self.title = "Edit Profile"
        doIniticalConfug()
        // Do any additional setup after loading the view.
    }

    func doIniticalConfug() {
        imagePicker.delegate = self
        containerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.black, radius: 4.0, opacity: 0.35)
        imgProfile.makeCornerRadiusWithValue(imgProfile.frame.width/2)
        imgProfile.layer.borderWidth = 3
        imgProfile.layer.borderColor = UIColor.white.cgColor
        
    }
    @IBAction func actionSelectImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)

    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfileVC" {
            let childVC = segue.destination as? EditProfileTableViewController
            childVC?.userId = userId
            childVC?.profileImage = self.imgProfile.image
            self.delegate = childVC
        }
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgProfile.image = pickedImage
        }
        if #available(iOS 11.0, *) {
            print(info[UIImagePickerControllerImageURL])
        } else {
            // Fallback on earlier versions
        }
        picker.dismiss(animated: true, completion: nil)
        self.delegate?.didProfileImageSelected(image: self.imgProfile.image!)
    }
}



