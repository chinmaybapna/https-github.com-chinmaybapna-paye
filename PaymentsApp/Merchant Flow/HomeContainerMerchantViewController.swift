//
//  HomeContainerMerchantViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 29/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeContainerMerchantViewController: UIViewController {
    
    var sideMenuOpen = false
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var merchantProfileImageView: UIImageView!
    
    @IBOutlet weak var sideMenuConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var transactionsButton : UIButton!
    @IBOutlet weak var contactlessPayButton : UIButton!
    @IBOutlet weak var goOnlineButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("yes", forKey: "isLoggedIn")
        UserDefaults.standard.set("merchant", forKey: "role")
        
        merchantProfileImageView.layer.cornerRadius = 25
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        //print(UserDefaults.standard.string(forKey: "userId")!)
        self.db.collection("user_profile_image_urls").document(UserDefaults.standard.string(forKey: "userId")!).getDocument { (docSnapshot, error) in
            if error != nil {
                //do something
                print(error)
            } else {
                if let doc = docSnapshot, doc.exists {
                    let data = doc.data()
                    if let data = data {
                        let profileImageURL = data["imageURL"] as? String
                        print(profileImageURL!)
                        self.merchantProfileImageView.sd_setImage(with: URL(string: profileImageURL!),
                                                                  placeholderImage: UIImage(named: "circle"),
                                                                  options: SDWebImageOptions.highPriority,
                                                                  progress: nil) { (downloadedImage, error, cacheType, url) in
                                                                    if(error != nil) {
                                                                        print(error)
                                                                    }
                        }
                    }
                }
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        view.addGestureRecognizer(panGesture)
        
        transactionsButton.layer.cornerRadius = 20
        contactlessPayButton.layer.cornerRadius = 20
        goOnlineButton.layer.cornerRadius = 70
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHome),
                                               name: NSNotification.Name("ShowHome"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showBankAccounts),
                                               name: NSNotification.Name("ShowBankAccounts"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showRegisteredDevices),
                                               name: NSNotification.Name("ShowRegisteredDevices"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSettings),
                                               name: NSNotification.Name("ShowSettings"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showContactUs),
                                               name: NSNotification.Name("ShowContactUs"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logOut),
                                               name: NSNotification.Name("LogOut"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func showHome() {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func showBankAccounts() {
        performSegue(withIdentifier: "showBankAccounts", sender: nil)
    }
    
    @objc func showRegisteredDevices() {
        performSegue(withIdentifier: "showRegisteredDevices", sender: nil)
    }
    
    
    @objc func showSettings() {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    @objc func showContactUs() {
        performSegue(withIdentifier: "showContactUs", sender: nil)
    }
    
    @objc func logOut() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        performSegue(withIdentifier: "logged_out", sender: nil)
    }
    
    
    @IBAction func menuButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -278
            
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func viewPanned(gestureRecogniser : UIPanGestureRecognizer) {
        sideMenuOpen = false
        sideMenuConstraint.constant = -278
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
