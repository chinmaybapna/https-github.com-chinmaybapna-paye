//
//  ContactUsViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 28/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var emailUsButton : UIButton!
    @IBOutlet weak var instagramButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailUsButton.layer.cornerRadius = 20
        instagramButton.layer.cornerRadius = 20
        
    }
}
