//
//  CategoriesTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 28/04/21.
//

import UIKit

class BottomView: UIView {
    
    var view: UIView!

    override func addSubview(_ view: UIView) {
        let bottomview = UIView(frame: CGRect(x: 0, y: 35, width: 100, height: 2))
        bottomview.backgroundColor = UIColor.red
        addSubview(bottomview)
    }    
}
class CategoriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var lineView  = UIView()
    
    @IBOutlet weak var collectionViewShowProducts: UICollectionView!
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionViewShowProducts.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true
        
        addHorizontalTeamList()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addHorizontalTeamList() {

        //let scrollView = UIScrollView(frame: CGRect(x: 0,y: 0, width: self.view.frame.width, height: 60))
        var frame : CGRect?
        
        let teamsCategory = ["Smartphones","Speakers","Headsets","Televisions","Refrigirator","Washing Machiones"]
        for i in 0..<teamsCategory.count {
            let button = UIButton(type: .custom)
            if i == 0 {
                frame = CGRect(x: 10, y: 10, width: 130, height: 40)
            }else{
                frame = CGRect(x: CGFloat(i * 140), y: 10, width: 130, height: 40)
            }

            button.frame = frame!
            button.tag = i
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
            button.setTitle(teamsCategory[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            
            lineView = BottomView()
            lineView.backgroundColor=UIColor.red
            button.addSubview(lineView)
            
            if button.tag == 0 {
                lineView.isHidden = false
            }else{
                lineView.isHidden = true
            }
            
            scrollView.addSubview(button)
        }

            scrollView.contentSize = CGSize( width: 840, height: scrollView.frame.size.height)
            scrollView.backgroundColor = .white
            //self.view.addSubview(scrollView)
        }

    @objc func selectCategory(sender: UIButton) {
    
        for views in scrollView.subviews{
             
            if views.isKind(of: UIButton.self) {
                
                if views.tag == sender.tag {
                    
                    for subviews in views.subviews {
                        if subviews .isKind(of: BottomView.self) {
                            subviews.isHidden = false
                        }
                    }
                   
                }else{
                    for subviews in views.subviews {
                        if subviews .isKind(of: BottomView.self) {
                            subviews.isHidden = true
                        }
                    }
                }
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
        
    
}
