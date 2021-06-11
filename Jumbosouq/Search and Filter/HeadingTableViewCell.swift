//
//  HeadingTableViewCell.swift
//  Jumbosouq
//
//  Created by Immanuel Infant Raj S on 08/06/21.
//

import UIKit


protocol HeadingCellDelegate: AnyObject {
    func showAllProductPressed()
}

class HeadingTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSeeAllProducts: UIButton!
    var delegate: HeadingCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        btnSeeAllProducts.addShadow30()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didActionSelectAll(_ sender: Any) {
        delegate?.showAllProductPressed()
    }
}
