//
//  CustomerFeedbackViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 01/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class CustomerFeedbackViewController: UIViewController {
    
    @IBOutlet weak var commentsTextView : UITextView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var shareButton: UIButton!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        commentsTextView.layer.cornerRadius = 10
        ratingView.layer.cornerRadius = 20
        shareButton.layer.cornerRadius = 20
        
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
}
