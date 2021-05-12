//
//  Singleton.swift
//  Jumbosouq
//
//  Created by Roche on 12/05/21.
//

import UIKit

class Singleton {
    
    static let shared = Singleton()
    private init(){
        
    }
    
    var isFBLogin:Bool = false
    var isGoogleLogin:Bool = false
    var isGuestLogin:Bool = false
    

}
