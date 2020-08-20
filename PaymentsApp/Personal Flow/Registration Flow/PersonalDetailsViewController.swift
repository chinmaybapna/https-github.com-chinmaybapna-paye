//
//  PersonalDetailsViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 25/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class PersonalDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkBoxImageView : UIImageView!
    @IBOutlet weak var termsAndConditionsLabel : UILabel!
    @IBOutlet weak var privacyPolicyLabel : UILabel!
    
    var isCheckBoxChecked = false
    
    private var datePicker : UIDatePicker?
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = UserDefaults.standard.string(forKey: "nameTextFieldInput"), let DOB =  UserDefaults.standard.string(forKey: "DOBTextFieldInput"), let email = UserDefaults.standard.string(forKey: "emailTextFieldInput") {
            nameTextField.text = name
            DOBTextField.text = DOB
            emailTextField.text = email
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(showCheckMark))
        checkBoxImageView.isUserInteractionEnabled = true
        checkBoxImageView.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(showTermsAndConditions))
        termsAndConditionsLabel.isUserInteractionEnabled = true
        termsAndConditionsLabel.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(showPrivacyPolicy))
        privacyPolicyLabel.isUserInteractionEnabled = true
        privacyPolicyLabel.addGestureRecognizer(tapGesture3)
        
        nameTextField.delegate = self
        DOBTextField.delegate = self
        emailTextField.delegate = self
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        DOBTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        continueButton.layer.cornerRadius = 20
        
        nameTextField.layer.cornerRadius = 10
        DOBTextField.layer.cornerRadius = 10
        emailTextField.layer.cornerRadius = 10
        
        nameTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        DOBTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        emailTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        DOBTextField.attributedPlaceholder = NSAttributedString(string: "Date of Birth", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        if nameTextField.text != "" || DOBTextField.text != "" || emailTextField.text != "" {
            UserDefaults.standard.set(nameTextField.text, forKey: "nameTextFieldInput")
            UserDefaults.standard.set(DOBTextField.text, forKey: "DOBTextFieldInput")
            UserDefaults.standard.set(emailTextField.text, forKey: "emailTextFieldInput")
        }
        performSegue(withIdentifier: "show_t&c", sender: nil)
    }
    
    @objc func showPrivacyPolicy(tapGestureRecognizer: UITapGestureRecognizer) {
        if nameTextField.text != "" || DOBTextField.text != "" || emailTextField.text != "" {
            UserDefaults.standard.set(nameTextField.text, forKey: "nameTextFieldInput")
            UserDefaults.standard.set(DOBTextField.text, forKey: "DOBTextFieldInput")
            UserDefaults.standard.set(emailTextField.text, forKey: "emailTextFieldInput")
        }
        performSegue(withIdentifier: "show_privacy_policy", sender: nil)
    }
    
    @objc func viewTapped(gestureRecogniser : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        DOBTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @IBAction func continueButtonPressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var date: Date = Date()
        if let selectedDate = DOBTextField.text {
            date = dateFormatter.date(from: selectedDate)!
        }
        
        if nameTextField.text == "" || DOBTextField.text == "" || emailTextField.text == "" {
            let alert = UIAlertController(title: "Invaild Input", message: "Please give valid inputs.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            alert.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
            alert.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
            alert.view.layer.cornerRadius = 0.5 * alert.view.bounds.size.width
            present(alert, animated: true, completion: nil)
            nameTextField.text = ""
            DOBTextField.text = ""
            emailTextField.text = ""
        }
            
        else if yearsBetweenDate(startDate: date, endDate: Date()) < 18 {
            DOBTextField.text = ""
            let alert = UIAlertController(title: "", message: "You should be above 18 years to register to the app.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
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
            if let dob = DOBTextField.text {
                UserDefaults.standard.set(dob, forKey: "dob")
            }
            if let email = emailTextField.text {
                UserDefaults.standard.set(email, forKey: "email")
            }
            
            if nameTextField.text != "" || DOBTextField.text != "" || emailTextField.text != "" {
                UserDefaults.standard.set(nameTextField.text, forKey: "nameTextFieldInput")
                UserDefaults.standard.set(DOBTextField.text, forKey: "DOBTextFieldInput")
                UserDefaults.standard.set(emailTextField.text, forKey: "emailTextFieldInput")
            }
            
            performSegue(withIdentifier: "personal_details_validated", sender: nil)
        }
    }
    
    func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year], from: startDate, to: endDate)
        
        return components.year!
    }
}
