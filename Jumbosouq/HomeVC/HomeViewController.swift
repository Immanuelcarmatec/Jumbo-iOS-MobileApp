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
class HomeViewController: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    @IBOutlet weak var navigationHomeItem: UINavigationItem!
    @IBOutlet weak var scrollViewMainContent: UIScrollView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var lblShowAddress: UILabel!
    @IBOutlet weak var txtFieldSerach: UITextField!
    @IBOutlet weak var imgViewFirstBanner: UIImageView!
    @IBOutlet weak var imgViewSecondBanner: UIImageView!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor.systemBackground
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        scrollViewMainContent.contentSize = CGSize(width: self.view.frame.size.width, height: 2000)
        txtFieldSearch.addShadow()
        lblShowAddress.addFont18()
        self.addNavBarImage()
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
    
    
}

