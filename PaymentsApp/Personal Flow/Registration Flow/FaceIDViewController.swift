//
//  FaceIDViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 10/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import LocalAuthentication

class FaceIDViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let context = LAContext()
        var error : NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        //perform segue
                        print("face recognised")
                        self?.performSegue(withIdentifier: "face_id_verified", sender: nil)
                    } else {
                        print("use pin")
                        self?.performSegue(withIdentifier: "use_pin", sender: nil)
                    }
                }
            }
        } else {
            print("biometry not available")
            performSegue(withIdentifier: "use_pin", sender: nil)
        }
    }
}
