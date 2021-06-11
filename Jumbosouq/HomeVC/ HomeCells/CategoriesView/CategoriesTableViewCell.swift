//
//  CategoriesTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 28/04/21.
//

import UIKit
import CarbonKit

class BottomView: UIView {
    
    var view: UIView!

    override func addSubview(_ view: UIView) {
        let bottomview = UIView(frame: CGRect(x: 0, y: 35, width: 100, height: 2))
        bottomview.backgroundColor = UIColor.red
        addSubview(bottomview)
    }    
}


class CategoriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CarbonTabSwipeNavigationDelegate {
  

    @IBOutlet weak var scrollView: UIView!
    
    var lineView  = UIView()
    
    @IBOutlet weak var collectionViewShowProducts: UICollectionView!
    
    let items = ["Smart Phones","Speakers","Headsets","Television"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionViewShowProducts.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true
        
        let setitem = CarbonTabSwipeNavigation.init(items: items, delegate:self)
        setitem.delegate = self
        setitem.setSelectedColor(themeColor(), font: UIFont(name: "Geomanist-Regular", size: 15)!)
        setitem.setNormalColor(UIColor.black, font:UIFont(name: "Geomanist-Regular", size: 15)!)
        setitem.setIndicatorColor(themeColor())
        setitem.setTabExtraWidth(self.frame.width/10)
        self.scrollView.addSubview(setitem.view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CategoriesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 120.0, height: 250.0)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
       self.window?.rootViewController!.present(newViewController, animated: true, completion: nil)
            }
     
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {
        print(index)
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        print(index)
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController{
        
        print(index)
        let page = UIViewController()
        return page
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didFinishTransitionTo index: UInt) {
        print(index)
    }
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willBeginTransitionFrom index: UInt) {
        print(index)
    }
        
}
