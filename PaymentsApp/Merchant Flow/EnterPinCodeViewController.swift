//
//  VerifyPinForLoginViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 04/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class EnterPinCodeViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var otpTextField1: UITextField!
    @IBOutlet weak var otpTextField2: UITextField!
    @IBOutlet weak var otpTextField3: UITextField!
    @IBOutlet weak var otpTextField4: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmButton.layer.cornerRadius = 20
        
        otpTextField1.backgroundColor = .clear
        otpTextField2.backgroundColor = .clear
        otpTextField3.backgroundColor = .clear
        otpTextField4.backgroundColor = .clear
        
        otpTextField1.underlined()
        otpTextField2.underlined()
        otpTextField3.underlined()
        otpTextField4.underlined()
        
        otpTextField1.delegate = self
        otpTextField2.delegate = self
        otpTextField3.delegate = self
        otpTextField4.delegate = self
        
        otpTextField1.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) {
            if(textField == otpTextField1) {
                otpTextField2.becomeFirstResponder()
            }
            
            if(textField == otpTextField2) {
                otpTextField3.becomeFirstResponder()
            }
            
            if(textField == otpTextField3) {
                otpTextField4.becomeFirstResponder()
            }
            
            if(textField == otpTextField4) {
                otpTextField4.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            if(textField == otpTextField2) {
                otpTextField1.becomeFirstResponder()
            }
            
            if(textField == otpTextField3) {
                otpTextField2.becomeFirstResponder()
            }
            
            if(textField == otpTextField4) {
                otpTextField3.becomeFirstResponder()
            }
            
            if(textField == otpTextField1) {
                otpTextField1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }
    
    @IBAction func confirmButtonPressed() {
        let otp1  = otpTextField1.text
        let otp2  = otpTextField2.text
        let otp3  = otpTextField3.text
        let otp4  = otpTextField4.text
        let pin = otp1! + otp2! + otp3! + otp4!
        UserDefaults.standard.set(pin, forKey: "pin")
        
        let loginUrl = "https://paye-backend-adminpanel.herokuapp.com/api/users/login"
        let loginParameters: [String: Any] = [
                "phone": UserDefaults.standard.string(forKey: "phoneNumber")!,
                "pin": pin
        ]
        AF.request(URL(string: loginUrl)!, method: .post, parameters: loginParameters as Parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                print(json)
                let token = json["token"].string
                let userId = json["user"]["_id"].string
                let groupId = json["user"]["userGroupId"].string
                let name = json["user"]["name"].string
                let isNewAccount = json["user"]["pinChanged"].bool
                let isSubAcc = json["user"]["details"]["isSubAcc"].bool
                print(isSubAcc)
                print(isNewAccount)
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.set(groupId, forKey: "userGroupId")
                UserDefaults.standard.set(name, forKey: "name")
                
                if token == nil {
                    print("token", token)
                    let alert = UIAlertController(title: "Invaild PIN", message: "Please enter a valid PIN.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
                    alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
                    alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
                    self.present(alert, animated: true, completion: nil)
                    self.otpTextField1.text = ""
                    self.otpTextField2.text = ""
                    self.otpTextField3.text = ""
                    self.otpTextField4.text = ""
                } else {
                    if !isNewAccount! && isSubAcc! {
                        self.performSegue(withIdentifier: "user_logged_in_for_first_time", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "pin_verified_for_login", sender: nil)
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
}
