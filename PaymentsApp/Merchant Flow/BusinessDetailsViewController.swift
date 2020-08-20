//
//  BusinessDetailsViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 28/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class BusinessDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var categoryTextField : UITextField!
    @IBOutlet weak var addressLineTextField : UITextField!
    @IBOutlet weak var postCodeTextField : UITextField!
    
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var termsAndConditionsLabel : UILabel!
    @IBOutlet weak var privacyPolicyLabel : UILabel!
    
    var isCheckBoxChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = UserDefaults.standard.string(forKey: "nameTextFieldInput"), let category =  UserDefaults.standard.string(forKey: "categoryTextFieldInput"), let addressLine = UserDefaults.standard.string(forKey: "addressLineTextFieldInput"), let postCode = UserDefaults.standard.string(forKey: "postCodeTextFieldInput") {
            nameTextField.text = name
            categoryTextField.text = category
            postCodeTextField.text = postCode
            addressLineTextField.text = addressLine
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        let tapGestur1 = UITapGestureRecognizer(target: self, action: #selector(showCheckMark))
        checkBoxImageView.isUserInteractionEnabled = true
        checkBoxImageView.addGestureRecognizer(tapGestur1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(showTermsAndConditions))
        termsAndConditionsLabel.isUserInteractionEnabled = true
        termsAndConditionsLabel.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(showPrivacyPolicy))
        privacyPolicyLabel.isUserInteractionEnabled = true
        privacyPolicyLabel.addGestureRecognizer(tapGesture3)
        
        nameTextField.delegate = self
        categoryTextField.delegate = self
        addressLineTextField.delegate = self
        postCodeTextField.delegate = self
        
        nameTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        categoryTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        addressLineTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        postCodeTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)

        nameTextField.layer.cornerRadius = 10
        categoryTextField.layer.cornerRadius = 10
        addressLineTextField.layer.cornerRadius = 10
        postCodeTextField.layer.cornerRadius = 10
        
        continueButton.layer.cornerRadius = 20
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        categoryTextField.attributedPlaceholder = NSAttributedString(string: "Category", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        addressLineTextField.attributedPlaceholder = NSAttributedString(string: "Address Line", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        postCodeTextField.attributedPlaceholder = NSAttributedString(string: "Post Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == postCodeTextField {
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    @objc func showCheckMark(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if !isCheckBoxChecked {
            isCheckBoxChecked = true
            tappedImage.image = #imageLiteral(resourceName: "ticked_checkbox")
        } else {
            isCheckBoxChecked = false
            tappedImage.image = #imageLiteral(resourceName: "checkBox")
        }
    }
    
    @objc func showTermsAndConditions(tapGestureRecognizer: UITapGestureRecognizer) {
        if nameTextField.text != "" || categoryTextField.text != "" || addressLineTextField.text != "" || postCodeTextField.text != "" {
            UserDefaults.standard.set(nameTextField.text, forKey: "nameTextFieldInput")
            UserDefaults.standard.set(categoryTextField.text, forKey: "categoryTextFieldInput")
            UserDefaults.standard.set(addressLineTextField.text, forKey: "addressLineTextFieldInput")
            UserDefaults.standard.set(postCodeTextField.text, forKey: "postCodeTextFieldInput")
        }
        performSegue(withIdentifier: "show_t&c", sender: nil)
    }
    
    @objc func showPrivacyPolicy(tapGestureRecognizer: UITapGestureRecognizer) {
        if nameTextField.text != "" || categoryTextField.text != "" || addressLineTextField.text != "" || postCodeTextField.text != "" {
            UserDefaults.standard.set(nameTextField.text, forKey: "nameTextFieldInput")
            UserDefaults.standard.set(categoryTextField.text, forKey: "categoryTextFieldInput")
            UserDefaults.standard.set(addressLineTextField.text, forKey: "addressLineTextFieldInput")
            UserDefaults.standard.set(postCodeTextField.text, forKey: "postCodeTextFieldInput")
        }
        performSegue(withIdentifier: "show_privacy_policy", sender: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func continueButtonPressed() {
        if nameTextField.text == "" || categoryTextField.text == "" || addressLineTextField.text == "" || postCodeTextField.text == "" {
            let alert = UIAlertController(title: "Invaild Input", message: "Please give valid inputs.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
            alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
            alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
            present(alert, animated: true, completion: nil)
            nameTextField.text = ""
            categoryTextField.text = ""
            addressLineTextField.text = ""
            postCodeTextField.text = ""
        }
        else if !isCheckBoxChecked {
            let alert = UIAlertController(title: "", message: "Please agree to terms and conditions and privacy policy.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
            alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
            alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
            present(alert, animated: true, completion: nil)
        }
        else {
            if let name = nameTextField.text {
                UserDefaults.standard.set(name, forKey: "name")
            }
            if let category = categoryTextField.text {
                UserDefaults.standard.set(category, forKey: "category")
            }
            if let addressLine = addressLineTextField.text {
                UserDefaults.standard.set(addressLine, forKey: "addressLine")
            }
            if let postCode = postCodeTextField.text {
                UserDefaults.standard.set(postCode, forKey: "postCode")
            }
            
            if nameTextField.text != "" || categoryTextField.text != "" || addressLineTextField.text != "" || postCodeTextField.text != "" {
                UserDefaults.standard.set(nameTextField.text, forKey: "nameTextFieldInput")
                UserDefaults.standard.set(categoryTextField.text, forKey: "categoryTextFieldInput")
                UserDefaults.standard.set(addressLineTextField.text, forKey: "addressLineTextFieldInput")
                UserDefaults.standard.set(postCodeTextField.text, forKey: "postCodeTextFieldInput")
            }
            
            performSegue(withIdentifier: "business_details_validated", sender: nil)
            
        }
    }
}
