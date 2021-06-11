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
class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    @IBOutlet weak var btnCart: UIBarButtonItem!
    @IBOutlet weak var btnFavourite: UIBarButtonItem!
    @IBOutlet var viewSearchbar: UIView!
    @IBOutlet var footerView: UIView!
    
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
    
    class removeSearch: UITapGestureRecognizer {
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController!.navigationBar.barTintColor = UIColor.systemBackground
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        txtFieldSearch.addShadow()
        
        
        let logoimage = UIImage(named: "img_logo") //Your logo url here
        let logoimageView = UIImageView(image: logoimage)
        logoimageView.contentMode = .scaleAspectFill
        logoimageView.frame = CGRect(x: 50, y: 45, width: 150, height: 50)
        self.navigationController?.view.addSubview(logoimageView)
        
        
        let appearance = UITabBarAppearance()
           appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeColor()]
           tabBar.standardAppearance = appearance
        tabBar.selectedItem = tabBar.items?.first
        
        
        let button = UIButton(type: .custom)
       // button.setImage(UIImage(named: "img_search"), for: .normal)
        let imageView = UIImageView(frame: CGRect(x: txtFieldSearch.frame.size.width - 95 , y: 10, width: 35, height: txtFieldSearch.frame.size.height-20))
        imageView.backgroundColor = themeColor()
        let image = UIImage(named: "Search_white")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        let imageViewBackground = UIImageView(frame: CGRect(x: txtFieldSearch.frame.size.width - 100 , y:0, width: 200, height: txtFieldSearch.frame.size.height))
        imageViewBackground.backgroundColor = themeColor()
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.frame = CGRect(x: txtFieldSearch.frame.size.width - 100 , y: 0, width: 100, height: 30)
        button.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        button.backgroundColor = themeColor()
        txtFieldSearch.rightView = button
        txtFieldSearch.rightViewMode = .always
        txtFieldSearch .addSubview(imageViewBackground)//img_search_white
        txtFieldSearch .addSubview(imageView)//img_search_white

                
        self.tblViewListProducts.backgroundColor = UIColor.white
        self.tblViewListProducts.delegate = self
        self.tblViewListProducts.dataSource = self
        
        self.tblViewSearchProducts.backgroundColor = UIColor.white
        self.tblViewSearchProducts.delegate = self
        self.tblViewSearchProducts.dataSource = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        
        timer.invalidate() // just in case this button is tapped multiple times
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        CustomActivityIndicator.shared.show(uiView: self.view, labelText: "Fetching favourites for you")
        self.tblViewListProducts.isHidden = true
        
        self.tabBarController?.selectedIndex = 0
        
        
        
        self.hideKeyboardWhenTappedAround()

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    
    @objc func update() {
        // Something cool
        CustomActivityIndicator.shared.hide(uiView: self.view, delay: 0.5)
        self.tblViewListProducts.isHidden = false
    }
    
    @objc func search() {
        tblViewSearchProducts.isHidden = false
        Singleton.sharedManager.searchitem = txtFieldSearch.text!
        let tapGesture = removeSearch(target: self, action: #selector(removeSearchTapped))
        tblViewSearchProducts.addGestureRecognizer(tapGesture)
        tblViewSearchProducts.reloadData()
    }
    @objc func removeSearchTapped(){
        tblViewSearchProducts.isHidden = true
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
                return 10
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
                    return weekdealcell!
             
                }else{
                    let identifier = "SearchProductTableViewCell"
                    var weekdealcell: SearchProductTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchProductTableViewCell
                   tableView.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    weekdealcell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableViewCell") as? SearchProductTableViewCell
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
          self.present(newViewController, animated: false, completion: nil)
    }
}
