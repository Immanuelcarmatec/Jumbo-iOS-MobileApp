//
//  HomeViewController.swift
//  Jumbosouq
//
//  Created by Roche on 06/04/21.
//

import Foundation
import UIKit
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var lblShowAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldSearch.addShadow()
        lblShowAddress.addFont18()
    }
    
    
}

