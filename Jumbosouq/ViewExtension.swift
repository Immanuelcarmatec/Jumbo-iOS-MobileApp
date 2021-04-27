//
//  ViewExtension.swift
//  Jumbosouq
//
//  Created by Roche on 29/03/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


//Constant Declarations
let baseURL = "https://www.jumbosouq.com/rest/default/V1/"

let headers:HTTPHeaders = [
    "Content-Type": "application/json",
    "Authorization": "gyqkm36xhtq6q6hkqm4dcgz2rw5h3vqp"
   ]

func getAuthorisationToken(){
    
    //AF.request(baseURL, method: .post).authenticate(user: "username", password: "pwd").responseJSON{
    let parameters: [String: Any] = [ "username":"carmatec", "password":"ABCD@1234"]
    let URLStr = baseURL + "integration/admin/token"
    
    AF.request(URLStr, method: .post).authenticate(username: "carmatec", password: "ABCD@1234")
        .responseJSON{
        response in
            print(response.result)
    }

    /*
    let request = AF.request(URLStr, method: .post,parameters: parameters, headers: headers).authenticate(username: "carmatec", password: "ABCD@1234")
     request.responseJSON { response in
      switch response.result {
      case .success:
        if let json = response.data {
               do{
                  let data = try JSON(data: json)
                  print(data)
                //  CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)

                  let jsonData: Data = response.data!
                  let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSArray
                  
                  if((jsonDict) != nil){
                      //self.tableViewArray = jsonDict?.mutableCopy() as! NSMutableArray
                     // self.tableView.reloadData()
                  }
                   
               }
               catch{
               print("JSON Error")
                  //CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)

               }

           }
      
      case .failure(let error):
        print(error)
          //CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)

      }

  }*/
    
}
    






let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
var validation = Validation()
let defaults = UserDefaults.standard

//Chck existing user
func userAlreadyExist() -> Bool {

    if (defaults.object(forKey: "username") != nil) {
        return true
    }

    return false
}


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
        
        let leftView = UILabel(frame: CGRect(x: 50, y: 0, width: 7, height: 26))
        leftView.backgroundColor = .clear

        self.leftView = leftView
        self.leftViewMode = .always
        self.contentVerticalAlignment = .center
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


