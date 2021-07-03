//
//  WeekDealTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 15/04/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireURLCache5


protocol WeekDealCellDelegate: class {
    func showProductPressed(index: Int)
}

class WeekDealTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    var delegate: WeekDealCellDelegate?
    
    class MyTapGesture: UITapGestureRecognizer {
        var indexValue = 0
    }
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)


    // MARK: - Image Loading
    private func loadImage(url:String, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = URL(string: url)!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }



    @IBOutlet weak var collectionViewShowProducts: UICollectionView!
    var productsArray = [Any]()
    var productItems = Array<Any>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionViewShowProducts.register(UINib(nibName: "WeekDealCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "WeekDealCollectionViewCell")
        
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        
        self.getAuthorisationToken()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getAuthorisationToken(){
        
        //AF.request(baseURL, method: .post).authenticate(user: "username", password: "pwd").responseJSON{
        let parameters: [String: Any] = [ "username":bearreUSername, "password":bearerPassword]
        let URLStr = baseURL + "integration/admin/token"
        let header:HTTPHeaders = [
            "Content-Type": "application/json",
           ]
        
        AF.request(URLStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header) .responseJSON{
                response in
            Singleton.sharedManager.bearertoken = response.value! as! String
            self.callProducts()

        }
        
    }
    
    func callProducts() {
        let parameters: [String: Any] = [ "searchCriteria[filter_groups][0][filters][0][field]":"category_id",
            "searchCriteria[filter_groups][0][filters][0][value]":"494",
            "searchCriteria[filter_groups][0][filters][0][condition_type]":"eq",
            "searchCriteria[pageSize]":"20"
        ]
        let URLStr = baseURL + "products"
        
        let headers:HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " +  Singleton.sharedManager.bearertoken
           ]

        
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
                                self.productsArray = jsonDict?.object(forKey: "items") as! [Any]
                                self.collectionViewShowProducts.reloadData()
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

           }.cache(maxAge: 10)

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      

        let cell: WeekDealCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDealCollectionViewCell", for: indexPath) as! WeekDealCollectionViewCell
        
        productItems = iterateProducts()
        cell.tag = indexPath.item
        let currentProduct = productItems[indexPath.item] as! NSDictionary
        let imagevalue = currentProduct.value(forKey: "small_image") as! String
        var imageURL = "https://www.jumbosouq.com/pub/media/catalog/product" + imagevalue as String
        imageURL = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        let itemNumber = NSNumber(nonretainedObject: currentProduct.value(forKey: "sku"))
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            cell.imgViewLoadPoduct.image = cachedImage
        } else {
            loadImage(url:imageURL){ [weak self] (image) in
                guard let self = self, let image = image else { return }
                cell.imgViewLoadPoduct.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
     
        let tapGesture = MyTapGesture(target: self, action: #selector(productViewTapped(sender:)))
        tapGesture.indexValue = indexPath.item
        cell.imgViewLoadPoduct.addGestureRecognizer(tapGesture)
        cell.imgViewLoadPoduct.layer.borderWidth = 0.2
        cell.imgViewLoadPoduct.layer.borderColor = UIColor.lightGray.cgColor
        return cell

    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        self.window?.rootViewController!.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func productViewTapped(sender: MyTapGesture) {
        Singleton.sharedManager.selectedProduct = productItems[sender.indexValue] as! NSDictionary
        delegate?.showProductPressed(index: sender.indexValue)
    }
    
    func iterateProducts() -> Array<Any> {
        
        var arrayofIteratedProducts :Array = Array<Any>()
        let countofproducts = self.productsArray.count - 1
        
        for products in 0...countofproducts {
            let productDict = self.productsArray[products] as! NSDictionary
            let customDict = productDict.object(forKey: "custom_attributes") as! NSArray
            
            let finaldic :NSMutableDictionary = NSMutableDictionary()
            
            let name = productDict.value(forKey: "name")
            let price = productDict.value(forKey: "price")
            let sku = productDict.value(forKey: "sku")
            finaldic.setValue(name, forKey: "name")
            finaldic.setValue(price, forKey: "price")
            finaldic.setValue(sku, forKey: "sku")

            for product in customDict {
                let prod = product as! NSDictionary
                let keyvalue = prod.object(forKey: "attribute_code") as! String
                let object = prod.object(forKey: "value") as Any
                finaldic.setValue(object, forKey: keyvalue)
            }
            
            arrayofIteratedProducts.append(finaldic)
        }
        
        return arrayofIteratedProducts
    }
    
}


