//
//  SearchProductTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 02/06/21.
//

import UIKit

class SearchProductTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAddCart: UIButton!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblActualPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblShowName: UILabel!
    @IBOutlet weak var imgViewShowProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnAddCart.layer.cornerRadius = 15
        btnAddCart.layer.borderWidth = 0.5
        btnAddCart.layer.borderColor = UIColor.lightGray.cgColor
        btnAddCart.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didActionAddCart(_ sender: Any) {
    }
    
}
