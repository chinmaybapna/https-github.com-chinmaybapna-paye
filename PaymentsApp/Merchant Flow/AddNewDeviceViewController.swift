//
//  AddNewDeviceViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 29/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire

class AddNewDeviceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private var datePicker : UIDatePicker?
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        DOBTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        nameTextField.delegate = self
        DOBTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        
        addButton.layer.cornerRadius = 20
        
        nameTextField.layer.cornerRadius = 10
        DOBTextField.layer.cornerRadius = 10
        emailTextField.layer.cornerRadius = 10
        phoneTextField.layer.cornerRadius = 10
        
        nameTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        DOBTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        emailTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        phoneTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        DOBTextField.attributedPlaceholder = NSAttributedString(string: "Date of Birth", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        DOBTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func addButtonPressed() {
        if nameTextField.text == "", DOBTextField.text == "", emailTextField.text == "", phoneTextField.text == "" {
            //show error
        }

        else if phoneTextField.text!.count < 10 {
            //show error
        }
            
        else {
            saveNewAccountToBackend()
        }
    }
    
    func saveNewAccountToBackend() {
        let url = "https://paye-backend-adminpanel.herokuapp.com/api/users/register"
        let parameters : [String: Any] = [
            "name": nameTextField.text!,
            "phone": "+44" + phoneTextField.text!,
            "pin": "0000",
            "role": "merchant",
            "userGroupId": UserDefaults.standard.string(forKey: "userGroupId")!,
            "details": [
                "isSubAcc": true,
                "DOB": DOBTextField.text!,
                "email": emailTextField.text!
            ]
        ]
        AF.request(URL(string: url)!, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default).responseString { (response) in
            print(response.result)
            switch response.result {
            case .success(let success):
                self.performSegue(withIdentifier: "device_added", sender: nil)
                break
            case .failure(let error):
                break
            }
        }
    }
}
