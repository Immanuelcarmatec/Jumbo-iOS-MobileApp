//
//  CategoriesTableViewCell.swift
//  Jumbosouq
//
//  Created by Roche on 28/04/21.
//

import UIKit
import Alamofire

protocol CategoriesTableViewCellDelegate: AnyObject {
    func showProductPressed(index: Int)
}


class CategoriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CustomSegmentedControlDelegate {
   

    @IBOutlet weak var scrollView: UIView!
    
    var lineView  = UIView()
    
    var searchproductsArray = [Any]()
    var searchproductItems = Array<Any>()

    
    @IBOutlet weak var collectionViewShowProducts: UICollectionView!
    
    let items = ["Smart Phones","Speakers","Headsets","Television"]
    
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
    
    var delegate: CategoriesTableViewCellDelegate?
    
    class categoriesTG: UITapGestureRecognizer {
        var indexValue = 0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionViewShowProducts.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        self.collectionViewShowProducts.dataSource = self
        self.collectionViewShowProducts.delegate = self
        self.collectionViewShowProducts.alwaysBounceHorizontal = true
        
       /* setitem = CarbonTabSwipeNavigation.init(items: items, delegate:self)
        setitem.delegate = self
        setitem.setSelectedColor(themeColor(), font: UIFont(name: "Geomanist-Regular", size: 15)!)
        setitem.setNormalColor(UIColor.black, font:UIFont(name: "Geomanist-Regular", size: 15)!)
        setitem.setIndicatorColor(themeColor())
        setitem.setTabExtraWidth(self.frame.width/10)
        self.scrollView.addSubview(setitem.view)*/
        
        let size = UIScreen.main.bounds
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: size.width-14, height: 50), buttonTitle: ["Smart Phones","Speakers","Headsets"])
        codeSegmented.backgroundColor = .clear
        self.addSubview(codeSegmented)
        codeSegmented.delegate = self
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
            self.searchProducts(searchString: "smartphone")
        }
        
    }
    
    
    func searchProducts(searchString:String) {
        let searchString = "%" + searchString + "%"
        
        let parameters: [String: Any] = [ "searchCriteria[filter_groups][0][filters][0][field]":"name",
            "searchCriteria[filter_groups][0][filters][0][value]":searchString,
            "searchCriteria[filter_groups][0][filters][0][condition_type]":"like",
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
                            if((jsonDict) != nil){
                                self.searchproductsArray = jsonDict?.object(forKey: "items") as! [Any]
                        DispatchQueue.main.async {
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

             }

           }.cache(maxAge: 10)

        }
    }
    
    
    func iterateProducts() -> Array<Any> {
        
        var arrayofIteratedProducts :Array = Array<Any>()
        let countofproducts = self.searchproductsArray.count - 1
        
        for products in 0...countofproducts {
            let productDict = self.searchproductsArray[products] as! NSDictionary
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
        
    func change(to index: Int) {
        let products = ["smartphone","speaker","headset"]
        let searchString = products[index]
        self.searchProducts(searchString: searchString)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchproductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weekdealcell: CategoriesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        
        searchproductItems = iterateProducts()
        
        weekdealcell.tag = indexPath.row
        let currentProduct = searchproductItems[indexPath.row] as! NSDictionary
        let imagevalue = currentProduct.value(forKey: "small_image") as! String
        var imageURL = "https://www.jumbosouq.com/pub/media/catalog/product" + imagevalue
        imageURL = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        weekdealcell.lblProductName.text = currentProduct.value(forKey: "name") as? String
        
        let tapGesture = categoriesTG(target: self, action: #selector(productViewTapped(sender:)))
        tapGesture.indexValue = indexPath.item
        weekdealcell.imgViewShowProduct.addGestureRecognizer(tapGesture)
        
        
        let itemNumber = NSNumber(nonretainedObject: currentProduct.value(forKey: "sku"))
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            weekdealcell.imgViewShowProduct.image = cachedImage
        } else {
            loadImage(url:imageURL){ [weak self] (image) in
                guard let self = self, let image = image else { return }
                weekdealcell.imgViewShowProduct.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
        
        let priceString = currentProduct.value(forKey: "price") as! NSNumber
        let normalprice = "Actual Price:QAR " + priceString.stringValue
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:normalprice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        weekdealcell.lblRegularPrice.attributedText = attributeString
        
        let splPrice = Double(currentProduct.value(forKey: "special_price") as! String)!
        let roundedPrice =  String(splPrice.rounded())
        weekdealcell.lblSplPrice.text = "Special price: QAR " + roundedPrice + "0"
                
        return weekdealcell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 120.0, height: 250.0)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Singleton.sharedManager.selectedProduct = searchproductItems[indexPath.item] as! NSDictionary
        delegate?.showProductPressed(index: indexPath.item)
        }
     
    @objc func productViewTapped(sender: categoriesTG) {
        Singleton.sharedManager.selectedProduct = searchproductItems[sender.indexValue] as! NSDictionary
        delegate?.showProductPressed(index: sender.indexValue)
    }
        
}
