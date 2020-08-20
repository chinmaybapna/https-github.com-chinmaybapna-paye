//
//  AfterPaymentCompletionViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 24/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class AfterPaymentCompletionViewController: UIViewController {

    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingView.layer.cornerRadius = 20
        homeButton.layer.cornerRadius = 20

    }
    
}
