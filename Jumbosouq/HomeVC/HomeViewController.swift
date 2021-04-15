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
        
        self.navigationController!.navigationBar.barTintColor = UIColor.systemBackground
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
     //   scrollViewMainContent.contentSize = CGSize(width: self.view.frame.size.width, height: 2000)
        txtFieldSearch.addShadow()
        lblShowAddress.addFont18()
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
        return 2
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "FirstTableViewCell"
        let cell: FirstTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? FirstTableViewCell
        
        if indexPath.row == 0 {
            let cell: FirstTableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "FirstTableViewCell") as! FirstTableViewCell
                    //set the data here
                    return cell
                }
        else if indexPath.row == 1 {
                    let cell: WeekDealTableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "WeekDealTableViewCell") as! WeekDealTableViewCell
                    //set the data here
                    return cell
                }
        
    
     return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    
    
}

