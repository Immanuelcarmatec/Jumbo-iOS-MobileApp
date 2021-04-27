//
//  NewArrivalTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 19/04/21.
//

import UIKit

class NewArrivalTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewShowProducts: UICollectionView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionViewShowProducts.register(UINib(nibName: "NewArrivalCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "NewArrivalCollectionViewCell")
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NewArrivalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewArrivalCollectionViewCell", for: indexPath) as! NewArrivalCollectionViewCell
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: 140.0, height: 230.0)
       }
    
}
