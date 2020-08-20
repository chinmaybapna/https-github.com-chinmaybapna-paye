//
//  YouAreMerchantNowViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 04/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class YouAreMerchantNowViewController: UIViewController {
    
    @IBOutlet weak var homeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeButton.layer.cornerRadius = 20
        
        //send business data to backend
        let url = "https://paye-backend-adminpanel.herokuapp.com/api/users/register"
        let parameters : [String: Any] = [
                                          "name": UserDefaults.standard.string(forKey: "name")!,
                                          "phone": UserDefaults.standard.string(forKey: "phoneNumber")!,
                                          "pin": UserDefaults.standard.string(forKey: "pin")!,
                                          "role": "merchant",
                                          "details": [
                                                        "category": UserDefaults.standard.string(forKey: "category")!,
                                                        "addressLine": UserDefaults.standard.string(forKey: "addressLine")!,
                                                        "postCode": UserDefaults.standard.string(forKey: "postCode")!,
                                                        "isSubAcc" : false
                                                     ]
                                         ]
        AF.request(URL(string: url)!, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default).responseString { (response) in
            print(response.result)
            switch response.result {
            case .success(let success):
                self.login()
                break
            case .failure(let error):
                break
            }
        }
        
        UserDefaults.standard.removeObject(forKey: "nameTextFieldInput")
        UserDefaults.standard.removeObject(forKey: "categoryTextFieldInput")
        UserDefaults.standard.removeObject(forKey: "addressLineTextFieldInput")
        UserDefaults.standard.removeObject(forKey: "postCodeTextFieldInput")
    }
    
    func login() {
        let loginUrl = "https://paye-backend-adminpanel.herokuapp.com/api/users/login"
        let loginParameters: [String: Any] = [
            "phone": UserDefaults.standard.string(forKey: "phoneNumber")!,
            "pin": UserDefaults.standard.string(forKey: "pin")!
        ]
        AF.request(URL(string: loginUrl)!, method: .post, parameters: loginParameters as Parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            print(response.result)
            if let data = response.data {
                let json = try! JSON(data: data)
                let token = json["token"].string!
                let userId = json["user"]["_id"].string!
                let groupId = json["user"]["userGroupId"].string
                let name = json["user"]["name"].string
                
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.set(groupId, forKey: "userGroupId")
                UserDefaults.standard.set(name, forKey: "name")
                print(userId)
            }
            switch response.result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
