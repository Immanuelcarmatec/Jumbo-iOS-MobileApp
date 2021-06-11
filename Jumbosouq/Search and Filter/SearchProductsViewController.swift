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
        
    }
    
    
    @objc func search() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "SearchProductTableViewCell"
        var weekdealcell: SearchProductTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchProductTableViewCell
       tableView.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        weekdealcell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableViewCell") as? SearchProductTableViewCell
        return weekdealcell!
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
