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



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblViewListProductDetails.backgroundColor = UIColor.white
        self.tblViewListProductDetails.delegate = self
        self.tblViewListProductDetails.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let cell: ProductDetailTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? ProductDetailTableViewCell
        
       if indexPath.row == 0 {
                   tableView.register(UINib(nibName: "ProductDetailTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                   let firstcell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell
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
            return 600.0;//Choose your custom row height
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
