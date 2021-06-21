//
//  HomeViewController.swift
//  Jumbosouq
//
//  Created by Roche on 06/04/21.
//

import Foundation
import UIKit
import Alamofire

@available(iOS 13.0, *)
class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
   
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var btnCart: UIBarButtonItem!
    @IBOutlet weak var btnFavourite: UIBarButtonItem!
    @IBOutlet var viewSearchbar: UIView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var searchView: UIView!

    
    @IBOutlet weak var tblViewListProducts: UITableView!
    @IBOutlet weak var navigationHomeItem: UINavigationItem!
    @IBOutlet weak var scrollViewMainContent: UIScrollView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var lblShowAddress: UILabel!
    @IBOutlet weak var txtFieldSerach: UITextField!
    @IBOutlet weak var imgViewFirstBanner: UIImageView!
    @IBOutlet weak var imgViewSecondBanner: UIImageView!
    @IBOutlet weak var tblViewSearchProducts: UITableView!
    @IBOutlet weak var collviewWeeklyDeals: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    var timer = Timer()
    var searchproductsArray = [Any]()
    var searchproductItems = Array<Any>()
    class removeSearch: UITapGestureRecognizer {
        
    }
    
    class addSearch: UITapGestureRecognizer {
        
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        txtFieldSearch.addShadow()
        
        
        let logoimage = UIImage(named: "img_logo") //Your logo url here
        let logoimageView = UIImageView(image: logoimage)
        logoimageView.contentMode = .scaleAspectFill
        logoimageView.frame = CGRect(x: 50, y: 45, width: 150, height: 50)
        self.navigationController?.view.addSubview(logoimageView)
        
       /* let button1 = UIBarButtonItem(image: UIImage(named: "img_menu"), style: .plain, target: revealViewController(), action: #selector(revealViewController()?.revealSideMenu))*/

        
          let appearance = UITabBarAppearance()
           appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeColor()]
         self.tabBarController?.tabBar.standardAppearance = appearance
        
        let image = UIImage(named: "Search_white-1")
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        let imageViewBackground = UIImageView(frame: CGRect(x: txtFieldSearch.frame.size.width-80 , y:0, width: 80, height: txtFieldSearch.frame.size.height))
        imageViewBackground.backgroundColor = themeColor()
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        button.frame = CGRect(x: CGFloat(8) , y: CGFloat(3), width: CGFloat(40), height: CGFloat(txtFieldSearch.frame.size.height-5))
        imageViewBackground.addSubview(button)
        imageViewBackground.isUserInteractionEnabled = true
        imageViewBackground.isMultipleTouchEnabled = true
        button.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        txtFieldSearch .addSubview(imageViewBackground)//img_search_white
        txtFieldSearch.delegate = self

                
        self.tblViewListProducts.backgroundColor = UIColor.white
        self.tblViewListProducts.delegate = self
        self.tblViewListProducts.dataSource = self
        
        self.tblViewSearchProducts.backgroundColor = UIColor.white
        self.tblViewSearchProducts.delegate = self
        self.tblViewSearchProducts.dataSource = self
        
     //   self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
     //   self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        
        timer.invalidate() // just in case this button is tapped multiple times
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Fetching favourites for you")
        self.tblViewListProducts.isHidden = true
        
        self.tabBarController?.selectedIndex = 0
                
        self.hideKeyboardWhenTappedAround()

        
       /* NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)*/
    
    }
    
    @objc func update() {
        // Something cool
        CustomActivityIndicator.shared.hide(uiView: self.view, delay: 0.5)
        self.tblViewListProducts.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        CustomActivityIndicator.shared.show(uiView: self.view.superview!, labelText: "Searching your favourite items...")
        Singleton.sharedManager.searchitem = self.txtFieldSearch.text!
        self.searchProducts()
           textField.resignFirstResponder();
           return true;
       }
    
    @objc func search() {
        
        if txtFieldSearch.text!.count > 0 {
            CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Searching your favourite items...")
            let searchString = "%" + self.txtFieldSearch.text! + "%"
            Singleton.sharedManager.searchitem = searchString
            self.searchProducts()
        }else{
            alert(message: "No data", title: "Search your favourites here")
        }
    }
    @objc func removeSearchTapped(){
        tblViewSearchProducts.isHidden = true
        self.searchView.isHidden = true
        tblViewListProducts.reloadData()
    }
    
    @IBAction func didActionCart(_ sender: Any) {
    }
    
    @IBAction func didActionFavourite(_ sender: Any) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblViewSearchProducts {
            return 1
        }
        return 1
   }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblViewSearchProducts {
            if section == 0 {
                if self.searchproductsArray.count > 10 {
                    return 10
                }
                return searchproductsArray.count
            }
            return 2
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if(section == 0){
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        if(section == 0){
            return viewSearchbar
        }else {
            return nil
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "FirstTableViewCell"
        let cell: FirstTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? FirstTableViewCell
        
        if tableView == tblViewSearchProducts {
            
            if indexPath.section == 0 {
                var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                if (cell == nil) {
                    cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
                   }
                cell!.textLabel?.font = UIFont(name: "Geomanist-Regular", size: 20)
                if indexPath.row == 0 {
                    
                   let identifier = "HeadingTableViewCell"
                    var weekdealcell: HeadingTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? HeadingTableViewCell
                   tableView.register(UINib(nibName: "HeadingTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    weekdealcell = tableView.dequeueReusableCell(withIdentifier: "HeadingTableViewCell") as? HeadingTableViewCell
                    weekdealcell.delegate = self
                    let countlabel = "See All " + String(self.searchproductsArray.count)
                    weekdealcell.btnSeeAllProducts.titleLabel?.text = countlabel
                    return weekdealcell!
             
                }else{
                    searchproductItems = iterateProducts()
                    
                    let identifier = "SearchProductTableViewCell"
                    var weekdealcell: SearchProductTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchProductTableViewCell
                   tableView.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    weekdealcell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableViewCell") as? SearchProductTableViewCell
                    
                    weekdealcell.tag = indexPath.row
                    let currentProduct = searchproductItems[indexPath.row] as! NSDictionary
                    let imagevalue = currentProduct.value(forKey: "small_image") as! String
                    var imageURL = "https://www.jumbosouq.com/pub/media/catalog/product" + imagevalue
                    imageURL = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    let fileUrl = NSURL(string:imageURL)
                    weekdealcell.lblShowName.text = currentProduct.value(forKey: "name") as? String
                    
                    DispatchQueue.global().async {
                        let task = URLSession.shared.dataTask(with: fileUrl! as URL) { data, response, error in
                            guard let data = data, error == nil else { return }
                            DispatchQueue.main.async() {
                                if weekdealcell.tag == indexPath.row{
                                    weekdealcell.imgViewShowProduct.image = UIImage(data: data)
                                }
                            }
                        }
                        task.resume()
                    }
                    
                    
                    return weekdealcell!
                }
                
        }
          
            
        }else{
            
           if indexPath.row == 0 {
                       tableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                       let firstcell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell
                       return firstcell!
                    }
            else if indexPath.row == 1 {
                let identifier = "WeekDealTableViewCell"
                var weekdealcell: WeekDealTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? WeekDealTableViewCell
              tableView.register(UINib(nibName: "WeekDealTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                weekdealcell = tableView.dequeueReusableCell(withIdentifier: "WeekDealTableViewCell") as? WeekDealTableViewCell
                weekdealcell.delegate = self
                return weekdealcell!
            }else if indexPath.row == 2 {
                let identifier = "NewArrivalTableViewCell"
                var newarrivalcell: NewArrivalTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? NewArrivalTableViewCell
               tableView.register(UINib(nibName: "NewArrivalTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                newarrivalcell = tableView.dequeueReusableCell(withIdentifier: "NewArrivalTableViewCell") as? NewArrivalTableViewCell
                newarrivalcell.delegate = self
                return newarrivalcell!
            }else if indexPath.row == 3{
                let identifier = "CategoriesTableViewCell"
                var weekdealcell: CategoriesTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoriesTableViewCell
               tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                weekdealcell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as? CategoriesTableViewCell
                return weekdealcell!
            }
            
        
        }
        return cell
      
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tblViewSearchProducts {
            if indexPath.row == 0 {
                return 50.0;
            }
            return 200.0;
            
        }else{
            if indexPath.row == 0 {
                return 200.0;//Choose your custom row height
            }
            
            if indexPath.row == 1 {
                return 150.0;//Choose your custom row height
            }
            
            if indexPath.row == 2 {
                return 280.0;//Choose your custom row height
            }
            
            if indexPath.row == 3 {
                return 320.0;//Choose your custom row height
            }
            return 250.0;//Choose your custom row height
        }
                
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if tableView == tblViewListProducts {
            return footerView
        }
        
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if tableView == tblViewListProducts {
            return 80
        }
        return 0
    }
    
    func searchProducts() {
        let searchString = "%" + self.txtFieldSearch.text! + "%"
        
        let parameters: [String: Any] = [ "searchCriteria[filter_groups][0][filters][0][field]":"name",
            "searchCriteria[filter_groups][0][filters][0][value]":searchString,
            "searchCriteria[filter_groups][0][filters][0][condition_type]":"like"
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
                                self.searchproductsArray = jsonDict?.object(forKey: "items") as! [Any]
                                self.tblViewSearchProducts.isHidden = false
                                self.searchView.isHidden = false
                                let tapGesture = removeSearch(target: self, action: #selector(self.removeSearchTapped))
                                self.tblViewSearchProducts.addGestureRecognizer(tapGesture)
                                self.searchproductsArray = jsonDict?.object(forKey: "items") as! [Any]
                                self.tblViewSearchProducts.reloadData()
                                CustomActivityIndicator.shared.hide(uiView: self.view.superview!, delay: 2.5)

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
    
    
    func iterateProducts() -> Array<Any> {
        
        var arrayofIteratedProducts :Array = Array<Any>()
        let countofproducts = self.searchproductsArray.count - 1
        
        for products in 0...countofproducts {
            let productDict = self.searchproductsArray[products] as! NSDictionary
            print(productDict)
            let customDict = productDict.object(forKey: "custom_attributes") as! NSArray
            print(customDict.count)
            
            let finaldic :NSMutableDictionary = NSMutableDictionary()
            
            let name = productDict.value(forKey: "name")
            let price = productDict.value(forKey: "price")

            finaldic.setValue(name, forKey: "name")
            finaldic.setValue(price, forKey: "price")
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

extension HomeViewController : WeekDealCellDelegate, NewArrivalTableViewCellDelegate{
    
    func showProductPressed(index: Int) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
          self.present(newViewController, animated: false, completion: nil)
    }
    
}

extension HomeViewController: HeadingCellDelegate{
    func showAllProductPressed() {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SearchProductsViewController") as! SearchProductsViewController
        newViewController.searchproductItems = self.searchproductItems
          self.present(newViewController, animated: false, completion: nil)
    }
}

