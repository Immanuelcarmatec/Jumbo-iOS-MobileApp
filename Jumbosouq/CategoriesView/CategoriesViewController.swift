//
//  CategoriesViewController.swift
//  Jumbosouq
//
//  Created by Immanuel Infant Raj S on 14/06/21.
//

import UIKit
import Alamofire

class CategoriesViewController: UITableViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        //https://www.jumbosouq.com/rest/default/V1/
        self.getCategories()
        
    }
    
    
    func getCategories() {
        
        let URLStr = baseURL + "categories"
        
        let headers:HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " +  Singleton.sharedManager.bearertoken
           ]

        
        DispatchQueue.global(qos: .background).async {
        let request = AF.request(URLStr, headers: headers)
           request.responseJSON { response in
             switch response.result {
             case .success:
               if let json = response.data {
                      do{
                       let jsonDict = try JSONSerialization.jsonObject(with: json) as? NSDictionary
                            if((jsonDict) != nil){
                                print(jsonDict!)
                               /* self.searchproductsArray = jsonDict?.object(forKey: "items") as! [Any]
                                self.tblViewSearchProducts.isHidden = false
                                let tapGesture = removeSearch(target: self, action: #selector(self.removeSearchTapped))
                                self.tblViewSearchProducts.addGestureRecognizer(tapGesture)
                                self.searchproductsArray = jsonDict?.object(forKey: "items") as! [Any]*/
                        DispatchQueue.main.async {
                               // self.indicator.stopAnimating()

                            }
                        }
                      }
                      catch{
                      print("JSON Error")
                      }
                  }
             case .failure(let error):
               print(error)

             }

           }.cache(maxAge: 10)

        }
    }
    
    public struct Item {
        var name: String
        var detail: String
        
        public init(name: String, detail: String) {
            self.name = name
            self.detail = detail
        }
    }

    public struct Section {
        var name: String
        var items: [Item]
        var collapsed: Bool
        
        public init(name: String, items: [Item], collapsed: Bool = true) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }

    public var sectionsData: [Section] = [
        Section(name: "Home appliances", items: [
            Item(name: "MacBook", detail: "Apple's ultraportable laptop, trading portability for speed and connectivity."),
            Item(name: "MacBook Air", detail: "While the screen could be sharper, the updated 11-inch MacBook Air is a very light ultraportable that offers great performance and battery life for the price."),
            Item(name: "MacBook Pro", detail: "Retina Display The brightest, most colorful Mac notebook display ever. The display in the MacBook Pro is the best ever in a Mac notebook."),
            Item(name: "iMac", detail: "iMac combines enhanced performance with our best ever Retina display for the ultimate desktop experience in two sizes."),
            Item(name: "Mac Pro", detail: "Mac Pro is equipped with pro-level graphics, storage, expansion, processing power, and memory. It's built for creativity on an epic scale."),
            Item(name: "Mac mini", detail: "Mac mini is an affordable powerhouse that packs the entire Mac experience into a 7.7-inch-square frame."),
            Item(name: "OS X El Capitan", detail: "The twelfth major release of OS X (now named macOS)."),
            Item(name: "Accessories", detail: "")
        ]),
        Section(name: "Kitchen appliances", items: [
            Item(name: "iPad Pro", detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size."),
            Item(name: "iPad Air 2", detail: "The second-generation iPad Air tablet computer designed, developed, and marketed by Apple Inc."),
            Item(name: "iPad mini 4", detail: "iPad mini 4 puts uncompromising performance and potential in your hand."),
            Item(name: "Accessories", detail: "")
        ]),
        Section(name: "Built-in appliances", items: [
            Item(name: "iPhone 6s", detail: "The iPhone 6S has a similar design to the 6 but updated hardware, including a strengthened chassis and upgraded system-on-chip, a 12-megapixel camera, improved fingerprint recognition sensor, and LTE Advanced support."),
            Item(name: "iPhone 6", detail: "The iPhone 6 and iPhone 6 Plus are smartphones designed and marketed by Apple Inc."),
            Item(name: "iPhone SE", detail: "The iPhone SE was received positively by critics, who noted its familiar form factor and design, improved hardware over previous 4-inch iPhone models, as well as its overall performance and battery life."),
            Item(name: "Accessories", detail: "")
        ]),
        Section(name: "TV & Home Entertaintment", items: [
            Item(name: "iPhone 6s", detail: "The iPhone 6S has a similar design to the 6 but updated hardware, including a strengthened chassis and upgraded system-on-chip, a 12-megapixel camera, improved fingerprint recognition sensor, and LTE Advanced support."),
            Item(name: "iPhone 6", detail: "The iPhone 6 and iPhone 6 Plus are smartphones designed and marketed by Apple Inc."),
            Item(name: "iPhone SE", detail: "The iPhone SE was received positively by critics, who noted its familiar form factor and design, improved hardware over previous 4-inch iPhone models, as well as its overall performance and battery life."),
            Item(name: "Accessories", detail: "")
        ]),
        Section(name: "TV & Home Entertaintment", items: [
            Item(name: "iPhone 6s", detail: "The iPhone 6S has a similar design to the 6 but updated hardware, including a strengthened chassis and upgraded system-on-chip, a 12-megapixel camera, improved fingerprint recognition sensor, and LTE Advanced support."),
            Item(name: "iPhone 6", detail: "The iPhone 6 and iPhone 6 Plus are smartphones designed and marketed by Apple Inc."),
            Item(name: "iPhone SE", detail: "The iPhone SE was received positively by critics, who noted its familiar form factor and design, improved hardware over previous 4-inch iPhone models, as well as its overall performance and battery life."),
            Item(name: "Accessories", detail: "")
        ])
    ]
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoriesViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[section].collapsed ? 0 : sectionsData[section].items.count
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sectionsData[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
       // cell.detailLabel.text = item.detail
        
        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
       self.present(newViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sectionsData[section].name
        header.setCollapsed(sectionsData[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

}

extension CategoriesViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sectionsData[section].collapsed
        // Toggle collapse
        sectionsData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}

