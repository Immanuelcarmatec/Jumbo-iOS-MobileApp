//
//  Singleton.swift
//  Jumbosouq
//
//  Created by Roche on 12/05/21.
//

import UIKit

class Singleton:NSObject {
    
    private static let shared = Singleton()
    class var sharedManager : Singleton {
            return shared
        }

    
    var isFBLogin:Bool = false
    var isGoogleLogin:Bool = false
    var isGuestLogin:Bool = false
    var selectedProduct:NSDictionary = NSDictionary()
    var bearertoken = ""
    var searchitem = ""
    
}
