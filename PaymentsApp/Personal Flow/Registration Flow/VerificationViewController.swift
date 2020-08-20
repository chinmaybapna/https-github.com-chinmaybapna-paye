//
//  VerificationViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 23/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Firebase
import CountdownLabel
import Alamofire

class VerificationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var OtpField: UITextField!
    @IBOutlet weak var countdown : CountdownLabel!
    
    override func viewDidLoad() {
        
        print("view did load")
        
        OtpField.backgroundColor = #colorLiteral(red: 0.7373645306, green: 0.9292912483, blue: 0.7189010978, alpha: 1)
        
        resendButton.layer.cornerRadius = 5
        resendButton.isHidden = true
        
        OtpField.attributedPlaceholder = NSAttributedString(string: "OTP", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        super.viewDidLoad()
        verifyButton.layer.cornerRadius = 20
        OtpField.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        countdown.setCountDownTime(minutes: 30)
        countdown.start()
        
        loopToCheckTimer()
        
        //unhide resend button after 30 seconds
        unhideResend()
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    func unhideResend() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
            self.resendButton.isHidden = false
        }
    }
    
    func loopToCheckTimer() {
        DispatchQueue.main.async {
            if self.countdown.isFinished {
                print("finished")
            } else {
                self.loopToCheckTimer()
            }
        }
    }
    
    @IBAction func resendButtonPressed() {
        guard let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationId, error) in
            if error == nil {
                guard let verifyId = verificationId else { return }
                print(verifyId)
                UserDefaults.standard.setValue(verifyId, forKey: "verificationId")
                UserDefaults.standard.synchronize()
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        }
        //hide resend button
        resendButton.isHidden = true
        loopToCheckTimer()
        
        countdown.setCountDownTime(minutes: 30)
        countdown.start()
        
        unhideResend()
    }
    
    @IBAction func verifyButtonPressed() {
        guard let otpCode = OtpField.text else { return }
        guard let verificationId = UserDefaults.standard.string(forKey: "verificationId") else { return }
        //print(verificationId)
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
        Auth.auth().signInAndRetrieveData(with: credential) { (success, error) in
            if error == nil {
                //perform segue
                self.performSegue(withIdentifier: "otp_verified", sender: nil)
            } else {
                print("could not sign in", error?.localizedDescription)
                let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again", preferredStyle: .alert)
                ac.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
                ac.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
                ac.view.layer.cornerRadius = 0.5 * ac.view.bounds.size.width
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
                self.OtpField.text = ""
            }
        }
    }
}

extension UITextField {
    //func to get underlined text field
    func underlined() {
        let border = CALayer()
        let width = CGFloat(3.0)
        border.borderColor = #colorLiteral(red: 0.4807969332, green: 0.78446877, blue: 0.07518606633, alpha: 1)
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
