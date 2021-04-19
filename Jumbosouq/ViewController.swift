//
//  ViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import UIKit
import Alamofire


@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var btnFBlogin: UIButton!
    
    @IBOutlet weak var scrollViewContent: UIScrollView!
    @IBOutlet weak var btnGueestLogin: UIButton!
    @IBOutlet weak var btnLoginSignup: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if userAlreadyExist() {
            for view in self.view.subviews{
                view.removeFromSuperview()
            }
            let username:String = defaults.object(forKey: "username")! as! String
            let password:String = defaults.object(forKey: "password") as! String
            doLogin(username: username, password: password)
        }
     
       btnLoginSignup.addShadow()
        btnFBlogin.addShadow()
        btnGoogleLogin.addShadow()
        btnGueestLogin.addShadow()
                
        btnFBlogin.setImage(UIImage(named: "img_google_small"), for: .normal)
        btnFBlogin.imageEdgeInsets.left = -50
        
        btnGoogleLogin.setImage(UIImage(named: "img_google_small"), for: .normal)
        btnGoogleLogin.imageEdgeInsets.left = -50
        
        btnGueestLogin.setImage(UIImage(named: "img_google_small"), for: .normal)
        btnGueestLogin.imageEdgeInsets.left = -50
        
        btnFBlogin.titleLabel?.autoresizesSubviews = true
        btnLoginSignup.titleLabel?.autoresizesSubviews = true
        btnGoogleLogin.titleLabel?.autoresizesSubviews = true
        btnGueestLogin.titleLabel?.autoresizesSubviews = true
        
       
        
    }
    
    func doLogin(username: String, password:String) {
        let parameters: [String: Any] = [ "username":username, "password":password]
        let URLStr = baseURL + "integration/customer/token"
        
        CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Authenticating  existing credentials...")
        
        AF.request(URLStr, method: .post,  parameters: parameters, encoding: JSONEncoding.default, headers:headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                    if (response.response?.statusCode  == 200){
                        
                        defaults.set(username, forKey: "username")
                        defaults.set(password, forKey: "password")

                         let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                                   self.present(newViewController, animated: true, completion: nil)
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

