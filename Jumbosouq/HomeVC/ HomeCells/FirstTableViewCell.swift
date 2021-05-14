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
        let padding : CGFloat = 5
        
        var yPostion: CGFloat = 0


        
        for i in 0...numberOfPages{
            /*let view: UIView = UIView(frame: CGRect(x: xPostion + padding, y: padding, width: viewWidth, height: viewHeight))
               view.backgroundColor = UIColor.white
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            imageView.image = UIImage(named:banner1[i])
            view.addSubview(imageView)
               firstPagingScroll .addSubview(view)
            xPostion = view.frame.origin.x + viewWidth + padding*/
            
            
                let imageView = UIImageView()
                let x = self.frame.size.width * CGFloat(i)
                imageView.frame = CGRect(x: x, y: 0, width: self.frame.width, height: self.frame.height)
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(named:banner1[i])
                        
            firstPagingScroll.contentSize.width = firstPagingScroll.frame.size.width * CGFloat(i + 1)
            firstPagingScroll.addSubview(imageView)
           }
        //firstPagingScroll.contentSize = CGSize(width:xPostion+padding, height:firstPagingScroll.frame.size.height)
        
        let banner2 = ["img_banner2","img_banner2","img_banner2"]
        let secondnumberOfPages :Int = banner2.count-1
        
        for i in 0...secondnumberOfPages{
             /*  let view: UIView = UIView(frame: CGRect(x: yPostion + padding, y: padding, width: secondviewWidth, height: secondviewHeight))
               view.backgroundColor = UIColor.white
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            imageView.image = UIImage(named:banner2[i])
            view.addSubview(imageView)
            secondPagingScroll .addSubview(view)
            yPostion = view.frame.origin.x + secondviewWidth + padding*/
            
            let imageView = UIImageView()
            let x = self.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.frame.width, height: self.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named:banner2[i])
                    
            secondPagingScroll.contentSize.width = secondPagingScroll.frame.size.width * CGFloat(i + 1)
            secondPagingScroll.addSubview(imageView)
           }
      //  secondPagingScroll.contentSize = CGSize(width:yPostion+padding, height:secondPagingScroll.frame.size.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
