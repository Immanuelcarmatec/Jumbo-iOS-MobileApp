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

    @IBOutlet var viewSearchbar: UIView!
    @IBOutlet weak var tblViewListProducts: UITableView!
    @IBOutlet weak var navigationHomeItem: UINavigationItem!
    @IBOutlet weak var scrollViewMainContent: UIScrollView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var lblShowAddress: UILabel!
    @IBOutlet weak var txtFieldSerach: UITextField!
    @IBOutlet weak var imgViewFirstBanner: UIImageView!
    @IBOutlet weak var imgViewSecondBanner: UIImageView!
    
    @IBOutlet weak var collviewWeeklyDeals: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getAuthorisationToken()
        
        self.navigationController!.navigationBar.barTintColor = UIColor.systemBackground
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        txtFieldSearch.addShadow()
        self.addNavBarImage()
        
        self.tblViewListProducts.backgroundColor = UIColor.white
        self.tblViewListProducts.delegate = self
        self.tblViewListProducts.dataSource = self
    }
    
    func addNavBarImage() {

            let navController = navigationController!

            let image = UIImage(named: "img_logo") //Your logo url here
            let imageView = UIImageView(image: image)

            let bannerWidth = navController.navigationBar.frame.size.width
            let bannerHeight = navController.navigationBar.frame.size.height

            let bannerX = bannerWidth / 2  - (image?.size.width)! / 2
            let bannerY = bannerHeight / 2 - (image?.size.height)! / 2

            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit

            navigationItem.titleView = imageView
        }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
               return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return viewSearchbar
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "FirstTableViewCell"
        let cell: FirstTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? FirstTableViewCell
        
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
            return weekdealcell!
        }else if indexPath.row == 2 {
            let identifier = "NewArrivalTableViewCell"
            var newarrivalcell: NewArrivalTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? NewArrivalTableViewCell
           tableView.register(UINib(nibName: "NewArrivalTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            newarrivalcell = tableView.dequeueReusableCell(withIdentifier: "NewArrivalTableViewCell") as? NewArrivalTableViewCell
            return newarrivalcell!
        }else if indexPath.row == 3{
            let identifier = "CategoriesTableViewCell"
            var weekdealcell: CategoriesTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoriesTableViewCell
           tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            weekdealcell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as? CategoriesTableViewCell
            return weekdealcell!
        }
        
    
     return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 200.0;//Choose your custom row height
        }
        
        if indexPath.row == 1 {
            return 120.0;//Choose your custom row height
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

