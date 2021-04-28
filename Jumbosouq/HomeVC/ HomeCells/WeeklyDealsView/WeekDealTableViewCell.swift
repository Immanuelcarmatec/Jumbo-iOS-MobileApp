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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionViewShowProducts.register(UINib(nibName: "WeekDealCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "WeekDealCollectionViewCell")
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true

        
        //self.callProducts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func callProducts() {
    
        let parameters: [String: Any] = [ "searchCriteria[filter_groups][0][filters][0][field]":"category_id",
            "searchCriteria[filter_groups][0][filters][0][value]":"494",
            "searchCriteria[filter_groups][0][filters][0][condition_type]":"eq"]
        let URLStr = baseURL + "products"
         let request = AF.request(URLStr, parameters: parameters, headers: headers)
         request.responseJSON { response in
          switch response.result {
          case .success:
            if let json = response.data {
                   do{
                      let data = try JSON(data: json)
                      print(data)
                    //  CustomActivityIndicator.shared.hide(uiView: self.view, delay: 1.5)

                      let jsonData: Data = response.data!
                      let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSArray
                      
                      if((jsonDict) != nil){
                          //self.tableViewArray = jsonDict?.mutableCopy() as! NSMutableArray
                         // self.tableView.reloadData()
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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell: WeekDealCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDealCollectionViewCell", for: indexPath) as! WeekDealCollectionViewCell
        
        return cell

    }
    
}
