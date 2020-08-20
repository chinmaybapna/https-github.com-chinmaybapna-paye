//
//  AddBankAccountViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 24/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddBankAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var reEnterAccountTextField: UITextField!
    @IBOutlet weak var sortCodeTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        nameTextField.delegate = self
        accountTextField.delegate = self
        reEnterAccountTextField.delegate = self
        sortCodeTextField.delegate = self
        
        addButton.layer.cornerRadius = 20
        
        nameTextField.layer.cornerRadius = 10
        accountTextField.layer.cornerRadius = 10
        reEnterAccountTextField.layer.cornerRadius = 10
        sortCodeTextField.layer.cornerRadius = 10
        
        nameTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        accountTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        reEnterAccountTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        sortCodeTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        accountTextField.attributedPlaceholder = NSAttributedString(string: "Account Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        reEnterAccountTextField.attributedPlaceholder = NSAttributedString(string: "Re-enter Account Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        sortCodeTextField.attributedPlaceholder = NSAttributedString(string: "Sort Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 8
        if textField == sortCodeTextField {
            maxLength = 6
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @IBAction func addButtonPressed() {
        if let name = nameTextField.text, let accountNumber = accountTextField.text, let sortCode = sortCodeTextField.text {
            
            if accountNumber.count < 8 || sortCode.count < 6 {
                let alert = UIAlertController(title: "Invaild Input", message: "Please give valid inputs.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
                alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
                alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
                present(alert, animated: true, completion: nil)
                accountTextField.text = ""
                sortCodeTextField.text = ""
                reEnterAccountTextField.text = ""
            }
            else if accountTextField.text != reEnterAccountTextField.text {
                let alert = UIAlertController(title: "Bank account numbers don't match", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
                alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
                alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
                present(alert, animated: true, completion: nil)
                accountTextField.text = ""
                reEnterAccountTextField.text = ""
            }
            else {
                //send personal data to backend
                let url = "https://paye-backend-adminpanel.herokuapp.com/api/bankac/add"
                let header : HTTPHeaders = [
                    "Authorization": UserDefaults.standard.string(forKey: "token")!
                ]
                let parameters : [String: Any] = [
                    "acnumber": accountNumber,
                    "name": name,
                    "details": [
                        "sortCode": sortCode,
                    ]
                ]
                AF.request(URL(string: url)!, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: header).responseString { (response) in
                    print(response.result)
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
    }
}
