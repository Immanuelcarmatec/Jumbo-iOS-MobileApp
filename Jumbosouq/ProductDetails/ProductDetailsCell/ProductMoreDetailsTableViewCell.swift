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
        if (Singleton.sharedManager.selectedProduct.value(forKey: "description") != nil) {
            let deschtmlString =   Singleton.sharedManager.selectedProduct.value(forKey: "description") as! String
            self.webViewShowDescription.loadHTMLString(deschtmlString, baseURL: nil)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
