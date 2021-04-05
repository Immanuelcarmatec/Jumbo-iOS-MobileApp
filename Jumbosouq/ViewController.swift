//
//  ViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnFBlogin: UIButton!
    
    @IBOutlet weak var btnLoginSignup: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnLoginSignup.addShadow()
        btnFBlogin.addShadow()
        btnGoogleLogin.addShadow()
        
        
        btnFBlogin.setImage(UIImage(named: "img_google_small"), for: .normal)
        btnFBlogin.imageEdgeInsets.left = -50
        
        btnFBlogin.setImage(UIImage(named: "img_google_small"), for: .normal)
        btnFBlogin.imageEdgeInsets.left = -50
        
    }
    
    @IBAction func didActionLogin(_ sender: Any) {
      
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(newViewController, animated: true, completion: nil)
        
    }
    

}

