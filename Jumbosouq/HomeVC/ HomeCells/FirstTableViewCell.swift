//
//  FirstTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 15/04/21.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var firstPagingScroll: UIScrollView!
    @IBOutlet weak var secondPagingScroll: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        let banner1 = ["img_banner1","img_banner1","img_banner1"]
        
        let numberOfPages :Int = banner1.count-1

        firstPagingScroll.isPagingEnabled = true
        secondPagingScroll.isPagingEnabled = true
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        
        for i in 0...numberOfPages{
            frame.origin.x = self.firstPagingScroll.frame.size.width * CGFloat(i)
            frame.size = self.firstPagingScroll.frame.size
            let imageViewBanner = UIImageView(frame: frame)
            imageViewBanner.image = UIImage(named: banner1[i]);
            imageViewBanner.contentMode = .scaleAspectFit
            self.firstPagingScroll.addSubview(imageViewBanner)
           }
        firstPagingScroll.contentSize = CGSize(width: firstPagingScroll.frame.size.width * CGFloat(banner1.count), height: firstPagingScroll.frame.size.height)
        
        let banner2 = ["img_banner2","img_banner2","img_banner2"]
        let secondnumberOfPages :Int = banner2.count-1
        
        var imageframe = CGRect(x: 0, y: 0, width: 0, height: 0)

        for i in 0...secondnumberOfPages{
            imageframe.origin.x = self.secondPagingScroll.frame.size.width * CGFloat(i)
            imageframe.size = self.secondPagingScroll.frame.size
            let imageViewBanner = UIImageView(frame: imageframe)
            imageViewBanner.image = UIImage(named: banner2[i]);
            self.secondPagingScroll.addSubview(imageViewBanner)
           }
        secondPagingScroll.contentSize = CGSize(width: secondPagingScroll.frame.size.width * CGFloat(banner2.count), height: secondPagingScroll.frame.size.height)

     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
