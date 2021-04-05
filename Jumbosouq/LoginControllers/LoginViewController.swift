//
//  LoginViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import Foundation
import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtViewPassword: UITextField!
    @IBOutlet weak var txtViewUserName: UITextField!
    @IBOutlet weak var lblLogin: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtViewUserName.addShadow()
        txtViewPassword.addShadow()
        btnLogin.addShadow()
        btnSignUp.addShadow()
        lblLogin.addFont20()
        self.hideKeyboardWhenTappedAround()

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @IBAction func ddiActionLogin(_ sender: Any) {
        
        guard let name = txtViewUserName.text, let password = txtViewPassword.text else {
           return
        }
        
        let isValidateName = validation.validateName(name: name)
              if (isValidateName == false) {
                alert(message: "Enter valid Username")
                 return
              }
        
        let isValidatePass = validation.validatePassword(password: password)
        if (isValidatePass == false) {
            alert(message: "Enter valid Password")
           return
        }        
        doLogin()
        
    }
    
    @IBAction func didActionForgetPwd(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didActionSignUp(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    func doLogin(){
        let parameters: [String: Any] = [ "username":txtViewUserName.text!, "password":txtViewPassword.text!]
        let URLStr = baseURL + "integration/customer/token"
        
        AF.request(URLStr, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    if let json = response.data {
                           do{
                            let jsonDict:Dictionary = try (JSONSerialization.jsonObject(with: json) as? Dictionary<String, Any>)!
                             self.alert(message: jsonDict["message"] as! String)
                           }
                           catch{
                           print("JSON Error")

                           }

                       }
                
                case .failure(let error):
                  print(error)
                    
                }

               

        }
    }
}
