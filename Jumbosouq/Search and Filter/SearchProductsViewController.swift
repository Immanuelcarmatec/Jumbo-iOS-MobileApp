//
//  SearchProductsViewController.swift
//  Jumbosouq
//
//  Created by Roche on 01/06/21.
//

import UIKit

class SearchProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var tblViewListProducts: UITableView!
    @IBOutlet var viewSearchbar: UIView!
    var searchproductItems = Array<Any>()


    override func viewDidLoad() {
        super.viewDidLoad()
        print(Singleton.sharedManager.searchitem )
        print(Singleton.sharedManager.bearertoken )

        txtFieldSearch.text = Singleton.sharedManager.searchitem
        // Do any additional setup after loading the view.
        
        self.tblViewListProducts.backgroundColor = UIColor.white
        self.tblViewListProducts.delegate = self
        self.tblViewListProducts.dataSource = self
        self.tblViewListProducts.rowHeight = 150.0
        
        txtFieldSearch.addShadow()
        let image = UIImage(named: "Search_white-1")
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        let imageViewBackground = UIImageView(frame: CGRect(x: txtFieldSearch.frame.size.width-50 , y:0, width: 80, height: txtFieldSearch.frame.size.height))
        imageViewBackground.backgroundColor = themeColor()
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        button.frame = CGRect(x: CGFloat(8) , y: CGFloat(3), width: CGFloat(40), height: CGFloat(txtFieldSearch.frame.size.height-5))
        imageViewBackground.addSubview(button)
        imageViewBackground.isUserInteractionEnabled = true
        imageViewBackground.isMultipleTouchEnabled = true
        button.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        txtFieldSearch .addSubview(imageViewBackground)//img_search_white
    }
    
    
    @objc func search() {
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
            return 130
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
            return viewSearchbar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchproductItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Singleton.sharedManager.selectedProduct = searchproductItems[indexPath.row] as! NSDictionary
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
       self.present(newViewController, animated: true, completion: nil)
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
