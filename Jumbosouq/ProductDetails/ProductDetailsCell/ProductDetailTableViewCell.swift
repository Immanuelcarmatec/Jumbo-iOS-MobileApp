//
//  ProductDetailTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 14/05/21.
//

import UIKit
import WebKit

class ProductDetailTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         let number = row+1
        return String(number)
        }

        /*func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
            gradeTextField.text = gradePickerValues[row]
            self.view.endEditing(true)
        }*/
    
    @IBOutlet weak var imgViewLoadProductImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var webViewShowShortDescription: WKWebView!
    @IBOutlet weak var lblShowPrice: UILabel!
    
    @IBOutlet weak var pickerSelectQuantity: UIPickerView!
    @IBOutlet weak var lblStockStatus: UILabel!
    @IBOutlet weak var lblShowCode: UILabel!
    @IBOutlet weak var btnAddCart: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickerSelectQuantity.delegate = self
        pickerSelectQuantity.dataSource = self
        btnAddCart.addShadow()
       // btnAddCart.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didActionAddToCart(_ sender: Any) {
    }
}
