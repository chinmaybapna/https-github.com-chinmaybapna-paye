//
//  CreateNewPINViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 10/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class CreateNewPINViewController: UIViewController, UITextFieldDelegate {

     @IBOutlet weak var continueButton: UIButton!
       
       @IBOutlet weak var otpTextField1: UITextField!
       @IBOutlet weak var otpTextField2: UITextField!
       @IBOutlet weak var otpTextField3: UITextField!
       @IBOutlet weak var otpTextField4: UITextField!
       
       override func viewDidLoad() {
           super.viewDidLoad()

           continueButton.layer.cornerRadius = 20
       
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
       
       @IBAction func continueButtonPressed() {
           if otpTextField1.text == "" || otpTextField2.text == "" || otpTextField3.text == "" || otpTextField4.text == "" {
               let alert = UIAlertController(title: "Invaild Input", message: "Please give valid inputs.", preferredStyle: .alert)
               let action = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(action)
               alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
               alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
               alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
               present(alert, animated: true, completion: nil)
           } else {
               let otp1  = otpTextField1.text
               let otp2  = otpTextField2.text
               let otp3  = otpTextField3.text
               let otp4  = otpTextField4.text
               let pin = otp1! + otp2! + otp3! + otp4!
               print(pin)
               UserDefaults.standard.set(pin, forKey: "newPin")
               performSegue(withIdentifier: "pin_validated", sender: nil)
           }
       }
}
