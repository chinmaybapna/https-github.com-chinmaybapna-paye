//
//  RegistrationMerchantViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 04/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Firebase

class RegistrationMerchantViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var UKView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        phoneTextField.delegate = self
        phoneTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        UKView.layer.cornerRadius = 10
        UKView.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        continueButton.layer.cornerRadius = 20
        phoneTextField.layer.cornerRadius = 10
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Eg.- 79XXXXXXXX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc func viewTapped(gestureRecogniser : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func continueButtonPressed() {
        if phoneTextField.text!.count < 10 {
            let alert = UIAlertController(title: "Invalid Phone Number", message: "Please enter a valid phone number.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
            alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
            alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
            present(alert, animated: true, completion: nil)
            phoneTextField.text = ""
        }
        else {
            guard let phoneNumber = phoneTextField.text else { return }
            let phone = "+44" + phoneNumber
            PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationId, error) in
                if error == nil {
                    guard let verifyId = verificationId else { return }
                    print(verifyId)
                    UserDefaults.standard.setValue(verifyId, forKey: "verificationId")
                    UserDefaults.standard.setValue(phone, forKey: "phoneNumber")
                    UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: "phone_number_validated", sender: nil)
                } else {
                    print("error: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    }
}
