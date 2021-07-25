//
//  CartModel.swift
//  Jumbosouq
//
//  Created by Immanuel Infant Raj S on 15/07/21.
//

import UIKit
import Alamofire

class CartModel: NSObject {
    
    func createCart()  {
        //https://www.jumbosouq.com/rest/default/V1/
        
        
        
        let username:String = defaults.object(forKey: "username")! as! String
        let password:String = defaults.object(forKey: "password") as! String
        
        let parameters: [String: Any] = [ "username":username, "password":password]
        let URLStr = baseURL + "integration/admin/token"
        let header:HTTPHeaders = [
            "Content-Type": "application/json",
           ]
        
        AF.request(URLStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header) .responseJSON{
                response in
            let bearerToken = response.value! as! String
            
            let parameters: [String: Any] = ["customerId":username]
            
            let URLStr = baseURL + "carts/mine"
            
            let headers:HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer " +  bearerToken
               ]

            let request = AF.request(URLStr,parameters: parameters, headers: headers)
               request.responseJSON { response in
                 switch response.result {
                 case .success:
                   if let json = response.data {
                          do{
                           let jsonDict = try JSONSerialization.jsonObject(with: json) as? NSDictionary
                            DispatchQueue.main.async {
                                if((jsonDict) != nil){
                                    print(jsonDict!)
                                }
                            }
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

}
