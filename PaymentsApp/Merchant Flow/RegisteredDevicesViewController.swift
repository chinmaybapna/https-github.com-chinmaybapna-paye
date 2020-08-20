//
//  RegisteredDevicesViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 29/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisteredDevicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addDeviceButton: UIButton!
    @IBOutlet weak var removeDeviceButton: UIButton!
    
    var devices: [DeviceModal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        //tableView.isUserInteractionEnabled = false
        tableView.separatorColor = .clear
        
        let groupId = UserDefaults.standard.string(forKey: "userGroupId")!
        let url = "https://paye-backend-adminpanel.herokuapp.com/api/userGroup/get?id=\(groupId)"
    
        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                print(json)
                print(json["result"][0]["users"])
                if json["result"][0]["users"].count > 0 {
                    for i in 0...json["result"][0]["users"].count-1 {
                        let phone = json["result"][0]["users"][i]["phone"].string!
                        let name = json["result"][0]["users"][i]["name"].string!
                        let newDevice = DeviceModal(name: name, phone: phone)
                        self.devices.append(newDevice)
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
        
        addDeviceButton.layer.cornerRadius = 20
        removeDeviceButton.layer.cornerRadius = 20
        
        tableView.register(UINib(nibName: "RegisteredDeviceTableViewCell", bundle: nil), forCellReuseIdentifier: "registered_device_cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registered_device_cell", for: indexPath) as! RegisteredDeviceTableViewCell
        cell.phoneNumber.text = devices[indexPath.row].phone
        cell.name.text = devices[indexPath.row].name
        return cell
    }
}
