//
//  SideMenuViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 26/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["Home", "Bank Accounts", "Settings", "Contact Us", "Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = #colorLiteral(red: 0.4807969332, green: 0.78446877, blue: 0.07518606633, alpha: 1)
        //tableView.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "side_menu_options", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        //cell.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
        cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 25)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        
        switch indexPath.row {
            case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowHome"), object: nil)
            case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowBankAccounts"), object: nil)
            case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
            case 3: NotificationCenter.default.post(name: NSNotification.Name("ShowContactUs"), object: nil)
            case 4: NotificationCenter.default.post(name: NSNotification.Name("LogOut"), object: nil)
            default: break
        }
    }
}
