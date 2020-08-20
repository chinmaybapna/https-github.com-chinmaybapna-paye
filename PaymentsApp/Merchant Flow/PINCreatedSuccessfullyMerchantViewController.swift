//
//  PINCreatedSuccessfullyMerchantViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 04/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class PINCreatedSuccessfullyMerchantViewController: UIViewController {

    @IBOutlet weak var selectMembershipButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "name")!)
        print(UserDefaults.standard.string(forKey: "phoneNumber")!)
        print(UserDefaults.standard.string(forKey: "postCode")!)
        print(UserDefaults.standard.string(forKey: "category")!)
        print(UserDefaults.standard.string(forKey: "addressLine")!)
        print(UserDefaults.standard.string(forKey: "pin")!)
        
        selectMembershipButton.layer.cornerRadius = 20
    }
}
