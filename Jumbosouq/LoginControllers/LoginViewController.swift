//
//  LoginViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import Foundation
import UIKit
import Alamofire

@available(iOS 13.0, *)
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
        
        if (name.isEmpty) {
          alert(message: "Enter valid Username")
           return
        }
        if (password.isEmpty) {
          alert(message: "Enter valid Password")
           return
        }
        
      /* let isValidateName = validation.validateName(name: name)
              if (isValidateName == false) {
                alert(message: "Enter valid Username")
                 return
              }
        
        let isValidatePass = validation.validatePassword(password: password)
        if (isValidatePass == false) {
            alert(message: "Enter valid Password")
           return
        }*/
        doLogin(username: name, password:password)
        
    }
    
    @IBAction func didActionForgetPwd(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didActionSignUp(_ sender: Any) {
       let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(newViewController, animated: true, completion: nil)
        
        /*  let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                  self.present(newViewController, animated: true, completion: nil)*/
        
    }
    
    func doLogin(username: String, password:String) {
        let parameters: [String: Any] = [ "username":username, "password":password]
        let URLStr = baseURL + "integration/customer/token"
        
        CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Logging in...")
        
        AF.request(URLStr, method: .post,  parameters: parameters, encoding: JSONEncoding.default, headers:headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                    if (response.response?.statusCode  == 200){
                        
                        defaults.set(username, forKey: "username")
                        defaults.set(password, forKey: "password")
                        
                        print(response)
                        
                      //  User.init(id: <#T##Int?#>, name: <#T##String?#>)

                         let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                                   self.present(newViewController, animated: true, completion: nil)
                    }
                case .failure(let error):
                 CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                  print(error)
                    
                }

        }
    }
}
