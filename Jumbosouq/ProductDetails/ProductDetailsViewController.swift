//
//  ProductDetailsViewController.swift
//  Jumbosouq
//
//  Created by Roche on 14/05/21.
//

import UIKit

class ProductDetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tblViewListProductDetails: UITableView!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var navBar: UINavigationBar!

    class tapGestureBanner: UITapGestureRecognizer {
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblViewListProductDetails.backgroundColor = UIColor.white
        self.tblViewListProductDetails.delegate = self
        self.tblViewListProductDetails.dataSource = self
        
        let tapGesture = tapGestureBanner(target: self, action: #selector(bannerViewTapped))
        viewHeader.addGestureRecognizer(tapGesture)
        //addNavBarImage()
        
        let image = UIImage(named: "img_logo") //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 50, y: 0, width: 150, height: 50)
        self.navBar.addSubview(imageView)
        
    }
    
    @objc func bannerViewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var bannerView: UIView!
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (Singleton.sharedManager.selectedProduct.value(forKey: "description") != nil) {
           return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
               return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return viewHeader
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "ProductDetailTableViewCell"
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)

        
       if indexPath.row == 0 {
        
       tableView.register(UINib(nibName: "ProductDetailTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.rowHeight = 550
        tableView.estimatedRowHeight = 550
        let firstcell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell
        firstcell!.layer.anchorPointZ = CGFloat(indexPath.row);
        
        if (Singleton.sharedManager.selectedProduct.value(forKey: "short_description") != nil) {
            let shortdeschtmlString =   Singleton.sharedManager.selectedProduct.value(forKey: "short_description") as! String
              firstcell!.webViewShowShortDescription.loadHTMLString(shortdeschtmlString, baseURL: nil)
        }
     
        firstcell!.lblProductName.text = Singleton.sharedManager.selectedProduct.value(forKey: "name") as? String
        
        let imagevalue = Singleton.sharedManager.selectedProduct.value(forKey: "image") as! String
        var imageURL = "https://www.jumbosouq.com/pub/media/catalog/product" + imagevalue
        imageURL = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let fileUrl = NSURL(string:imageURL)
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: fileUrl! as URL) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    if firstcell!.tag == indexPath.row{
                        firstcell!.imgViewLoadProductImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
                   return firstcell!
    }
        
       else if indexPath.row == 1 {
           let identifier = "ProductMoreDetailsTableViewCell"
        tableView.register(UINib(nibName: "ProductMoreDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.rowHeight = 550
        tableView.estimatedRowHeight = 550
        let weekdealcell: ProductMoreDetailsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? ProductMoreDetailsTableViewCell
           return weekdealcell!
       }
        
    
     return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 550//Choose your custom row height
        }else if indexPath.row == 1{
            return 200//Choose your custom row height
        }
        
        return 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
