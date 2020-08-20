//
//  FirstViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 13/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var registerBusinessButton: UIButton!
    @IBOutlet weak var becomePartnerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerBusinessButton.layer.cornerRadius = 20
        becomePartnerButton.layer.cornerRadius = 20
    }
}
