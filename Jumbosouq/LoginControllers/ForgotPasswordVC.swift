//
//  ForgotPasswordVC.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import Foundation
import UIKit
import Alamofire

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var lblResetDescpn: UILabel!
    @IBOutlet weak var lblLinkSent: UILabel!
    @IBOutlet weak var viewConfirmation: UIView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblDescpn: UILabel!
    @IBOutlet weak var lblFPwd: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnReset.addShadow()
        btnReset.backgroundColor = BluethemeColor()
        txtEmail.addShadow()
        lblDescpn.addFont18()
        lblFPwd.addFont20()
        lblLinkSent.addFont20()
        lblResetDescpn.addFont18()
        self.hideKeyboardWhenTappedAround()

        self.viewConfirmation.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @IBAction func didActionResetPwd(_ sender: Any) {
        
        let isValidateName = validation.validateEmailId(emailID: txtEmail.text!)
              if (isValidateName == false) {
                alert(message: "Enter valid Email ID")
                 return
              }
        let parameters: [String: Any] = [ "email":txtEmail.text!, "template":"email_reset"]
        let URLStr = baseURL + "customers/password"
        
        let headers:HTTPHeaders = [
            "Content-Type": "application/json",
           ]

        
        AF.request(URLStr,method: .put, parameters:parameters, headers: headers)
                   .responseJSON { response in
                       if let data = response.data {
                        self.viewConfirmation.isHidden = false
                        self.lblResetDescpn.text = "If there is an account associated with " + self.txtEmail.text! + " you will receive an email with the link to reset password"
                       }else{

                       }
           }
        
    }
    
    @IBAction func didActionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
