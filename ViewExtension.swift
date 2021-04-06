//
//  ViewExtension.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import Foundation
import UIKit

//Constant Declarations
let baseURL = "https://www.jumbosouq.com/rest/default/V1/"
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
var validation = Validation()


//Input Validation
class Validation {
   public func validateName(name: String) ->Bool {
      // Length be 18 characters max and 3 characters minimum, you can always modify.
      let nameRegex = "^\\w{3,18}$"
      let trimmedString = name.trimmingCharacters(in: .whitespaces)
      let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
      let isValidateName = validateName.evaluate(with: trimmedString)
      return isValidateName
   }
   public func validaPhoneNumber(phoneNumber: String) -> Bool {
      let phoneNumberRegex = "^[6-9]\\d{9}$"
      let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
      let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
      let isValidPhone = validatePhone.evaluate(with: trimmedString)
      return isValidPhone
   }
   public func validateEmailId(emailID: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
      let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      let isValidateEmail = validateEmail.evaluate(with: trimmedString)
      return isValidateEmail
   }
   public func validatePassword(password: String) -> Bool {
      //Minimum 8 characters at least 1 Alphabet and 1 Number:
      let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
      let trimmedString = password.trimmingCharacters(in: .whitespaces)
      let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
      let isvalidatePass = validatePassord.evaluate(with: trimmedString)
      return isvalidatePass
   }
   public func validateAnyOtherTextField(otherField: String) -> Bool {
      let otherRegexString = "Your regex String"
      let trimmedString = otherField.trimmingCharacters(in: .whitespaces)
      let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
      let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
      return isValidateOtherString
   }
}



//ViewExtensions

extension UIImageView {

    func addShadow() {
        backgroundColor = .clear
        layer.cornerRadius = 15
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }
}

extension UILabel{
    func addFont20() {
       font =  UIFont(name: "Geomanist-Regular", size: 20)
    }
    
    func addFont18() {
       font =  UIFont(name: "Geomanist-Regular", size: 18)
    }
}

extension UIButton {

    func addShadow() {
       // backgroundColor = .clear
        layer.cornerRadius = 15
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height
        
            
            if height > 600 {
                titleLabel?.font = UIFont(name: "Geomanist-Bold", size: 20)
            }else{
                titleLabel?.font = UIFont(name: "Geomanist-Bold", size: 14)
            }
        titleLabel?.textColor = UIColor.black
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
}

extension UITextField {

    func addShadow() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray.cgColor
        clipsToBounds = true
        font = UIFont(name: "Geomanist-Regular", size: 20)
        textColor = UIColor.gray
    }
}

extension UIViewController {

    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let screenBounds = UIScreen.main.bounds
            let width = screenBounds.width
            let height = screenBounds.height
            
            if self.view.frame.origin.y == 0 {
                
                if height > 600 {
                    let deviceHeight = keyboardSize.height-80
                    self.view.frame.origin.y -= deviceHeight
                }else{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboardView))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

    @objc func dismissKeyboardView() {
            view.endEditing(true)
        }
}



