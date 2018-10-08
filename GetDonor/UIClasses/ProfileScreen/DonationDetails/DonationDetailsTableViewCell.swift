//
//  DonationDetailsTableViewCell.swift
//  GetDonor
//
//  Created by admin on 05/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

protocol DonationDetailsTableViewCellDelegate: class {
    func didDownloadFinished()
    func didViewReceiptPressed(receiptUrl: String)
}

class DonationDetailsTableViewCell: UITableViewCell,CellReusable {
    @IBOutlet weak var lblReceiptNumber: UILabel!
    @IBOutlet weak var lblPaymentMode: UILabel!
    @IBOutlet weak var lblPaymentModeValue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnDownloadReceipt: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnContainerView: UIStackView!
    weak var delegate: DonationDetailsTableViewCellDelegate?
    var model: Transaction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(offset: CGSize.init(width: 1, height: 1), color: UIColor.black, radius: 3.0, opacity: 0.25)
        prepareUI()
        
    }
    
    func prepareUI() {
        lblReceiptNumber.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblPaymentModeValue.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblPaymentMode.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblDate.font = UIFont.fontWithTextStyle(textStyle: .title1)
        lblAmount.font = UIFont.fontWithTextStyle(textStyle: .title1)

        lblAmount.textColor = UIColor.colorFor(component: .navigationBar)
        lblPaymentModeValue.textColor = UIColor.colorFor(component: .navigationBar)
        
        btnDownloadReceipt.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title3)
        btnDownloadReceipt.makeCornerRadiusWithValue(5.0, borderColor: nil)
        btnDownloadReceipt.backgroundColor = UIColor.colorFor(component: .button)
        btnDownloadReceipt.tintColor = UIColor.white

    }
    
    func configureCell(with model:Transaction?, forType:DonationDetailsType) {
        if let model = model {
            self.model = model
            switch forType{
            case .myDonation:
                populateMySelfCell(model: model)
            case .allDonations:
                populateAllDonationCell(model: model)
            }
            
        }
    }
    
    
    private func populateMySelfCell(model: Transaction) {
        btnContainerView.isHidden = false
        lblReceiptNumber.text = model.username ?? ""
        lblPaymentMode.text = "Payment Mode:"
        lblPaymentModeValue.text = model.mode ?? ""
        lblDate.text = model.addedon?.components(separatedBy: " ").first ?? ""
        if let amount = model.amount {
            lblAmount.text = "₹ " + amount

        }
        
        configureDownloadButton()
        
    }
    
    func configureDownloadButton() {
        
        if let url = model.receipt, let trxId = model.txnid, pdfFileAlreadySaved(url: url, fileName: trxId ) {
            btnDownloadReceipt.setTitle("View Receipt", for: .normal)
            self.btnDownloadReceipt.loadingIndicator(show: false, isCenter: true)
        }
        else{
            
            if let txnId = model.txnid{
                
                if DownloadingQueue.sharedInstance.isDownloading(id: txnId){
                    btnDownloadReceipt.setTitle("Downloading...", for: .normal)
                    btnDownloadReceipt.loadingIndicator(show: true, isCenter: true)
                }
                else{
                    btnDownloadReceipt.setTitle("Download Receipt", for: .normal)
                    btnDownloadReceipt.loadingIndicator(show: false)

                }

            }

        }
    }

    private func populateAllDonationCell(model: Transaction) {
        btnContainerView.isHidden = true
        lblReceiptNumber.text = model.txnid ?? ""
        lblPaymentMode.text = "Payment Mode:"
        lblPaymentModeValue.text = model.mode ?? ""
        lblDate.text = model.addedon?.components(separatedBy: " ").first ?? ""
        if let amount = model.amount {
            lblAmount.text = "₹ " + amount
            
        }

    }
    
    @IBAction func actionDownloadReceipt(_ sender: UIButton) {
        
        if let url = model.receipt, let trxId = model.txnid{
        if sender.title(for: .normal) == "Download Receipt" {
            self.btnDownloadReceipt.loadingIndicator(show: true, isCenter: true)
            savePdf(urlString: url, fileName: trxId)
        } else {
            showSavedPdf(url: url, fileName: trxId)
        }
        }
    }
    func savePdf(urlString:String, fileName:String) {
        self.btnDownloadReceipt.setTitle("Downloading...", for: .normal)
        DispatchQueue.global(qos: .background).async {
            DownloadingQueue.sharedInstance.add(id: fileName)
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                DispatchQueue.main.async {
                    self.btnDownloadReceipt.loadingIndicator(show: false, isCenter: true)
                    self.btnDownloadReceipt.setTitle("View Receipt", for: .normal)
                    DownloadingQueue.sharedInstance.remove(id: fileName)
                    self.delegate?.didDownloadFinished()
                }

                
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    func showSavedPdf(url:String, fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        // its your file! do what you want with it!
                        delegate?.didViewReceiptPressed(receiptUrl: url.absoluteString)

                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
    }
    
    // check to avoid saving a file multiple times
    func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
        var status = false
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        status = true
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
        return status
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
