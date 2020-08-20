//
//  AccountRegisteredSuccessfullyViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 25/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class AccountRegisteredSuccessfullyViewController: UIViewController {
    
    @IBOutlet weak var createPINCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPINCodeButton.layer.cornerRadius = 20
    }
    
}
