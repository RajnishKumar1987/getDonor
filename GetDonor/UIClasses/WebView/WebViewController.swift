//
//  WebViewController.swift
//  GetDonor
//
//  Created by admin on 21/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        showLoader(onViewController: self)
        loadWebView(with: urlString)
    }
    
    func loadWebView(with urlString: String)  {
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension WebViewController: UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        removeLoader(fromViewController: self)
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        removeLoader(fromViewController: self)
    }
}
