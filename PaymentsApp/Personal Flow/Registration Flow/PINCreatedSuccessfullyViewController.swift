//
//  PINCreatedSuccessfullyViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 25/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class PINCreatedSuccessfullyViewController: UIViewController {

    let db = Firestore.firestore()
    
    @IBOutlet weak var addBankAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBankAccountButton.layer.cornerRadius = 20
        
//        print(UserDefaults.standard.string(forKey: "name")!)
//        print(UserDefaults.standard.string(forKey: "phoneNumber")!)
//        print(UserDefaults.standard.string(forKey: "pin")!)
//        print(UserDefaults.standard.string(forKey: "dob")!)
//        print(UserDefaults.standard.string(forKey: "email")!)
        
        //send personal data to backend
        let url = "https://paye-backend-adminpanel.herokuapp.com/api/users/register"
        let parameters : [String: Any] =
        [
            "name": UserDefaults.standard.string(forKey: "name")!,
            "phone": UserDefaults.standard.string(forKey: "phoneNumber")!,
            "pin": UserDefaults.standard.string(forKey: "pin")!,
            "role": "customer",
            "details": [
                "dob": UserDefaults.standard.string(forKey: "dob")!,
                "email": UserDefaults.standard.string(forKey: "email")!,
                "isSubAcc": false
            ]
        ]
        AF.request(URL(string: url)!, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default).responseString { (response) in
            print(response.result)
            switch response.result {
            case .success(_):
                break
            case .failure(let error):
                break
            }
        }
        
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
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(userId, forKey: "userId")
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
        
        UserDefaults.standard.removeObject(forKey: "nameTextFieldInput")
        UserDefaults.standard.removeObject(forKey: "DOBTextFieldInput")
        UserDefaults.standard.removeObject(forKey: "emailTextFieldInput")
    }
}
