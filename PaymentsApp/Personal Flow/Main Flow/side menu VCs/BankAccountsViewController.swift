//
//  BankAccountsViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 27/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BankAccountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var bankAccounts : [BankAccountModal] = []
    
    @IBOutlet weak var addBankAccountButton: UIButton!
    @IBOutlet weak var removeBankAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .clear
        
        addBankAccountButton.layer.cornerRadius = 20
        removeBankAccountButton.layer.cornerRadius = 20
        
        tableView.register(UINib(nibName: "AddBankAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "bank_acc_cell")

        tableView.delegate = self
        tableView.dataSource = self
        
        let url = "https://paye-backend-adminpanel.herokuapp.com/api/bankac/getAll"
        let header : HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                if json["result"].count > 0 {
                    for i in 0...json["result"].count-1 {
                        let acNumber = json["result"][i]["acnumber"].string!
                        let acName = json["result"][i]["name"].string!
                        //print(acName)
                        //print(acNumber)
                        let newAccount = BankAccountModal(acNumber: acNumber, acName: acName)
                        self.bankAccounts.append(newAccount)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            switch response.result {
            case .success(_):
                print("success")
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bank_acc_cell", for: indexPath) as! AddBankAccountTableViewCell
        cell.bankAcName.text = bankAccounts[indexPath.row].acName
        cell.bankAcNNumber.text = bankAccounts[indexPath.row].acNumber
        return cell
    }
    
}
