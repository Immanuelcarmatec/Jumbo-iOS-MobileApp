//
//  SearchProductsViewController.swift
//  Jumbosouq
//
//  Created by Roche on 01/06/21.
//

import UIKit

class SearchProductsViewController: UIViewController {

    @IBOutlet weak var txtFieldSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Singleton.sharedManager.searchitem )
        txtFieldSearch.text = Singleton.sharedManager.searchitem
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
