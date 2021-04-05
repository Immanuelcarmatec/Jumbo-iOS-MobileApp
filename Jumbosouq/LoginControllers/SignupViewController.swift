//
//  SignupViewController.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtFirstName.addShadow()
        txtLastName.addShadow()
        txtPhoneNumber.addShadow()
        txtConfirmPassword.addShadow()
        txtPassword.addShadow()
        txtEmail.addShadow()
        btnContinue.addShadow()
        self.hideKeyboardWhenTappedAround()

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func didActionContinueSignUp(_ sender: Any) {
        
        guard let name = txtFirstName.text, let lastname = txtLastName.text , let phonenum = txtPhoneNumber.text, let password = txtPassword.text, let confirmpassword = txtConfirmPassword.text , let email = txtEmail.text else {
           return
        }
        
        let isValidateName = validation.validateName(name: name)
              if (isValidateName == false) {
                alert(message: "Enter valid First Name")
                 return
              }
        
        let isValidateLastName = validation.validateName(name: lastname)
              if (isValidateLastName == false) {
                alert(message: "Enter valid Last Name")
                 return
              }
        
        let isValidatePhoneNum = validation.validaPhoneNumber(phoneNumber: phonenum)
              if (isValidatePhoneNum == false) {
                alert(message: "Enter valid Phone number")
                 return
              }
        
        let isValidateEmail = validation.validateEmailId(emailID: email)
              if (isValidateEmail == false) {
                alert(message: "Enter valid Email ID")
                 return
              }
        let isValidatePassword = validation.validatePassword(password: password)
              if (isValidatePassword == false) {
                alert(message: "Enter valid Password")
                 return
              }
        
         if password != confirmpassword {
            alert(message: "Passwords doesn't match")
             return
         }
        
        doSignUP()
        
    }
    
    func doSignUP(){
        
    }
    
    @IBAction func didActionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
