//
//  MembershipViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 28/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class MembershipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var promoCodeTextField : UITextField!
    @IBOutlet weak var applyButton : UIButton!
    @IBOutlet weak var continueToPayButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promoCodeTextField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        promoCodeTextField.delegate = self
        
        applyButton.layer.cornerRadius = 10
        continueToPayButton.layer.cornerRadius = 20
        promoCodeTextField.layer.cornerRadius = 10
        
        tableView.register(UINib(nibName: "MembershipTableViewCell", bundle: nil), forCellReuseIdentifier: "membership_cell")

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = #colorLiteral(red: 0.4807969332, green: 0.78446877, blue: 0.07518606633, alpha: 1)
        
        promoCodeTextField.attributedPlaceholder = NSAttributedString(string: "Promo Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 3
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "membership_cell", for: indexPath) as! MembershipTableViewCell
           return cell
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
