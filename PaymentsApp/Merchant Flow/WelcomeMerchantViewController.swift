//
//  WelcomeMerchantViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 31/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import LocalAuthentication
import Alamofire

class WelcomeMerchantViewController: UIViewController {
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAccountButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
        
//        let parameters : [String : Any] = [
//            "id" : "5f298865354f7d001733d02b"
//        ]
//        AF.request(URL(string: "https://paye-backend-adminpanel.herokuapp.com/api/users/remove")!, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default).responseJSON { (response) in
//            print(response.result)
//            switch response.result {
//            case .success(_):
//                break
//            case .failure(let error):
//                print(error)
//                break
//            }
//        }
        
    }
    
    @IBAction func loginButtonTapped() {
        
        self.performSegue(withIdentifier: "logged_in_using_biometrics", sender: nil)
//        let context = LAContext()
//        var error : NSError?
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "Identify yourself"
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
//                DispatchQueue.main.async {
//                    if success {
//                        //perform segue
//                        print("face recognised")
//                        self?.performSegue(withIdentifier: "logged_in_using_biometrics", sender: nil)
//                    } else {
//                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again", preferredStyle: .alert)
//                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////                        self?.present(ac, animated: true, completion: nil)
//                    }
//                }
//            }
//        } else {
//            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(ac, animated: true, completion: nil)
//        }
    }
}
