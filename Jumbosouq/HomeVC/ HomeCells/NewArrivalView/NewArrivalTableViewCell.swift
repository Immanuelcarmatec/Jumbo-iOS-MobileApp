//
//  NewArrivalTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 19/04/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewArrivalTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewShowProducts: UICollectionView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionViewShowProducts.register(UINib(nibName: "NewArrivalCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "NewArrivalCollectionViewCell")
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true
        
        self.callProducts()

    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 140.0, height: 230.0)
       }
    
    
    func callProducts() {
        
        let parameters: [String: Any] = [ "searchCriteria[filter_groups][0][filters][0][field]":"category_id",
            "searchCriteria[filter_groups][0][filters][0][value]":"417",
            "searchCriteria[filter_groups][0][filters][0][condition_type]":"eq"]
        let URLStr = baseURL + "products"
        
        
        DispatchQueue.global(qos: .background).async {
            let request = AF.request(URLStr, parameters: parameters, headers: headers)
            request.responseJSON { response in
             switch response.result {
             case .success:
               if let json = response.data {
                      do{
                         let data = try JSON(data: json)
                         print(data)
                         let jsonData: Data = response.data!
                         let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSArray
                        DispatchQueue.main.async {
                            if((jsonDict) != nil){
                                
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
}
