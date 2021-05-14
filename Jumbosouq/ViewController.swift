//
//  ViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import FBSDKLoginKit




@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    
    @IBOutlet weak var btnFBlogin: UIButton!
    
    @IBOutlet weak var scrollViewContent: UIScrollView!
    @IBOutlet weak var btnGueestLogin: UIButton!
    @IBOutlet weak var btnLoginSignup: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var lblOR: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if userAlreadyExist() {
            
            btnFBlogin.isHidden = true
            btnLoginSignup.isHidden = true
            btnGoogleLogin.isHidden = true
            btnGueestLogin.isHidden = true
            lblOR.isHidden = true
            
            
            let username:String = defaults.object(forKey: "username")! as! String
            let password:String = defaults.object(forKey: "password") as! String
            doLogin(username: username, password: password)
        }
        
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
            btnFBlogin.isHidden = true
            btnLoginSignup.isHidden = true
            btnGoogleLogin.isHidden = true
            btnGueestLogin.isHidden = true
            lblOR.isHidden = true
                  
           }
        
     
        btnLoginSignup.addShadowRegularTitle()
        btnFBlogin.addShadowRegularTitle()
        btnGoogleLogin.addShadowRegularTitle()
        btnGueestLogin.addShadowRegularTitle()
                
       
        btnFBlogin.backgroundColor = fbColor()//(66, 103, 178)
        btnFBlogin.setImage(UIImage(named: "img_fbk"), for: .normal)
        btnFBlogin.imageEdgeInsets.left = -50
       // loginButton.frame = CGRect(x:25, y:0, width:btnFBlogin.frame.width-50, height:btnFBlogin.frame.height)
       // loginButton.backgroundColor = UIColor.clear
       // btnFBlogin.addSubview(loginButton)

        
        btnGoogleLogin.setImage(UIImage(named: "img_goog"), for: .normal)
        btnGoogleLogin.imageEdgeInsets.left = -50
        
        btnGueestLogin.setImage(UIImage(named: "img_guest_icon.png"), for: .normal)
        btnGueestLogin.imageEdgeInsets.left = -50
        
        btnFBlogin.titleLabel?.autoresizesSubviews = true
        btnLoginSignup.titleLabel?.autoresizesSubviews = true
        btnGoogleLogin.titleLabel?.autoresizesSubviews = true
        btnGueestLogin.titleLabel?.autoresizesSubviews = true
        
        btnLoginSignup.backgroundColor = themeColor()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
            DispatchQueue.main.async {
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.present(newViewController, animated: false, completion: nil)
            }
                  
           }
    }
    
    
    @IBAction func doFBLogin(_ sender: Any) {
        Singleton.shared.isFBLogin = true
        let loginButton = FBLoginButton()
        loginButton.sendActions(for:.touchUpInside)
    }
    
    
    @IBAction func doGoogleLogin(_ sender: Any) {
        Singleton.shared.isGoogleLogin = true
    }
    
    @IBAction func doGuestLogin(_ sender: Any) {
          let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                  self.present(newViewController, animated: true, completion: nil)
    }
    func doLogin(username: String, password:String) {
        let parameters: [String: Any] = [ "username":username, "password":password]
        let URLStr = baseURL + "integration/customer/token"
        
        CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Authenticating  existing credentials...")
        
        AF.request(URLStr, method: .post,  parameters: parameters, encoding: JSONEncoding.default, headers:headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                    if (response.response?.statusCode  == 200){
                        
                        defaults.set(username, forKey: "username")
                        defaults.set(password, forKey: "password")
                        
                        do {
                            // make sure this JSON is in the format we expect
                            let json = JSON(value)
                          //  defaults.set(json, forKey: "uid")
                            
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                                           self.present(newViewController, animated: true, completion: nil)
                                
                        }
                    }
                case .failure(let error):
                 CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                  print(error)
                    
                }

        }
    }
  
    
    @IBAction func didActionLogin(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(newViewController, animated: true, completion: nil)
        
    }

}

