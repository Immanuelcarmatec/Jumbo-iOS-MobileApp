//
//  BaseTabViewController.swift
//  Jumbosouq
//
//  Created by Immanuel Infant Raj S on 30/06/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class BaseTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        if (defaults.object(forKey: "username") != nil) {
            
            let username:String = defaults.object(forKey: "username")! as! String
            let password:String = defaults.object(forKey: "password") as! String
            self.doLogin(username: username, password: password)
           
        }else{
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                      newViewController.modalPresentationStyle = .overFullScreen
                      self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    
    
    func doLogin(username: String, password:String) {
        let parameters: [String: Any] = [ "username":username, "password":password]
        let URLStr = baseURL + "integration/customer/token"
        
        CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Authenticating  existing credentials...")
        
        let headers:HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " +  Singleton.sharedManager.bearertoken
           ]

        
        AF.request(URLStr, method: .post,  parameters: parameters, encoding: JSONEncoding.default, headers:headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    CustomActivityIndicator.shared.hide(uiView: self.view, delay: 0)
                    if (response.response?.statusCode  != 200){
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                  newViewController.modalPresentationStyle = .overFullScreen
                                  self.present(newViewController, animated: true, completion: nil)
                    }
                case .failure(let error):
                 CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                  print(error)
                    
                }

        }
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
