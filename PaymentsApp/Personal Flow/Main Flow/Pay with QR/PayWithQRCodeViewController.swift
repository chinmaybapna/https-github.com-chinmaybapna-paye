//
//  PayWithQRCodeViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 24/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class PayWithQRCodeViewController: UIViewController {
    @IBOutlet weak var payNowButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        payNowButton.layer.cornerRadius = 20
        
        amountTextField.layer.cornerRadius = 10
        nameTextField.layer.cornerRadius = 10
        
        nameTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        amountTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        amountTextField.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecogniser : UITapGestureRecognizer) {
           view.endEditing(true)
       }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
