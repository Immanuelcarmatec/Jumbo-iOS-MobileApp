//
//  ProfileViewController.swift
//  Jumbosouq
//
//  Created by Immanuel Infant Raj S on 30/06/21.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblViewProfile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "My Account"
        tblViewProfile.delegate = self
        tblViewProfile.dataSource = self

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
   }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if(section == 0){
            return 50
        }else{
            return 0
        }
    }
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "Default"
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)
        cell.imageView?.image = UIImage(named: "img_home_profile")
        cell.textLabel?.text = "Logout"
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Hello, Jumbosouq member", message: "Do you want to Logout", preferredStyle: UIAlertController.Style.alert)
        let callAction = UIAlertAction(title: "Logout", style: .default, handler: { action in
            defaults.setValue(nil, forKey: "username")
            defaults.setValue(nil, forKey: "password")
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                      newViewController.modalPresentationStyle = .overFullScreen
                      self.present(newViewController, animated: false, completion: nil)
            self.tabBarController?.selectedIndex = 0
            })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
               })
        alert.addAction(callAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
        
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
