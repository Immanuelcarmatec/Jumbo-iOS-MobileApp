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


        
        for i in 0...numberOfPages{
           
            let imageView = UIImageView();
                        imageView.contentMode = .scaleToFill;
                        imageView.image = UIImage(named: banner1[i]);
                        let xPos = CGFloat(i) * firstPagingScroll.bounds.size.width;
                        imageView.contentMode = .scaleAspectFill
            
                        imageView.frame = CGRect(x: xPos, y: 0, width: firstPagingScroll.bounds.size.width, height: firstPagingScroll.bounds.size.height);
            firstPagingScroll.contentSize.width = firstPagingScroll.frame.size.width * CGFloat(i+1);
            firstPagingScroll.contentSize.height = firstPagingScroll.frame.size.height;
            firstPagingScroll.addSubview(imageView);
            
              
           }
      
        
        let banner2 = ["img_banner2","img_banner2","img_banner2"]
        let secondnumberOfPages :Int = banner2.count-1
        
        for i in 0...secondnumberOfPages{
            let imageView = UIImageView();
                        imageView.contentMode = .scaleToFill;
                        imageView.image = UIImage(named: banner2[i]);
                        imageView.contentMode = .scaleAspectFill

                        let xPos = CGFloat(i) * secondPagingScroll.bounds.size.width;
                        imageView.frame = CGRect(x: xPos, y: 0, width: secondPagingScroll.bounds.size.width, height: secondPagingScroll.bounds.size.height);
            secondPagingScroll.contentSize.width = secondPagingScroll.frame.size.width * CGFloat(i+1);
            secondPagingScroll.contentSize.height = secondPagingScroll.frame.size.height;
            secondPagingScroll.addSubview(imageView);
           }
        

     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
