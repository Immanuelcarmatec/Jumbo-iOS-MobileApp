//
//  WeekDealTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 15/04/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeekDealTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionViewShowProducts: UICollectionView!
    var productsArray = [Any]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionViewShowProducts.register(UINib(nibName: "WeekDealCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "WeekDealCollectionViewCell")
        
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true
        self.collectionViewShowProducts.allowsSelection = true

        
        self.callProducts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func callProducts() {

        let parameters: [String: Any] = [ "searchCriteria[filter_groups][0][filters][0][field]":"category_id",
            "searchCriteria[filter_groups][0][filters][0][value]":"494",
            "searchCriteria[filter_groups][0][filters][0][condition_type]":"eq",
            "searchCriteria[pageSize]":"20"
        ]
        let URLStr = baseURL + "products"
        
        DispatchQueue.global(qos: .background).async {
        let request = AF.request(URLStr, parameters: parameters, headers: headers)
           request.responseJSON { response in
             switch response.result {
             case .success:
               if let json = response.data {
                      do{
                       let jsonDict = try JSONSerialization.jsonObject(with: json) as? NSDictionary
                        
                        DispatchQueue.main.async {
                            if((jsonDict) != nil){
                                print(jsonDict?.object(forKey: "items") ?? NSDictionary())
                                self.productsArray = jsonDict?.object(forKey: "items") as! [Any]
                                self.collectionViewShowProducts.reloadData()
                                //self.tableViewArray = jsonDict?.mutableCopy() as! NSMutableArray
                               // self.tableView.reloadData()
                            }
                        }
                      }
                      catch{
                      print("JSON Error")
                         //CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)
                      }
                  }
             case .failure(let error):
               print(error)
                 //CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)

             }

          }

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WeekDealCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDealCollectionViewCell", for: indexPath) as! WeekDealCollectionViewCell
        cell.isUserInteractionEnabled = true
        print(self.productsArray[indexPath.item])
        
        return cell

    }
    
  
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        self.window?.rootViewController!.present(newViewController, animated: true, completion: nil)
    }*/
    
}


