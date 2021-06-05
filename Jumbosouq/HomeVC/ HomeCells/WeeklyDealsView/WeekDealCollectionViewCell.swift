//
//  WeekDealCollectionViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 15/04/21.
//

import UIKit

class WeekDealCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgViewLoadPoduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.contentView.isUserInteractionEnabled = true
       /* self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 0.2
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath*/
        
    }

}
