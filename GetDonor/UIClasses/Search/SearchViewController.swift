//
//  SearchViewController.swift
//  GetDonor
//
//  Created by admin on 16/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        disableRefresh()
        // Do any additional setup after loading the view.
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableview.dequeueReusableCell(withIdentifier: "cell")!
    }
    
}






