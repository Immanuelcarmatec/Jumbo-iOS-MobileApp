//
//  ViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import UIKit

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
    
  
    
    @IBAction func didActionLogin(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(newViewController, animated: true, completion: nil)
        
    }

}

