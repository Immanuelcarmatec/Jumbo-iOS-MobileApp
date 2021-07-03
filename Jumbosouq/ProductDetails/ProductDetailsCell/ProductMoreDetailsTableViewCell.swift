//
//  ProductMoreDetailsTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 28/05/21.
//

import UIKit
import WebKit

class ProductMoreDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var webViewShowDescription: WKWebView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            if (Singleton.sharedManager.selectedProduct.value(forKey: "description") != nil) {
                let deschtmlString =   Singleton.sharedManager.selectedProduct.value(forKey: "description") as! String
                self.webViewShowDescription.loadHTMLStringWithMagic(content: deschtmlString, baseURL: nil)

            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension WKWebView {
    func loadHTMLStringWithMagic(content:String,baseURL:URL?){
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        loadHTMLString(headerString + content, baseURL: baseURL)
    }
}
