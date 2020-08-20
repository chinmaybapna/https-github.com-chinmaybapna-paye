//
//  HomeContainerViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 26/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Firebase

class HomeContainerViewController: UIViewController {
    
    var sideMenuOpen = false
    
    @IBOutlet weak var sideMenuConstraint : NSLayoutConstraint!
    @IBOutlet weak var scanQRAndPayButton: UIButton!
    @IBOutlet weak var contactlessPayButton: UIButton!
    @IBOutlet weak var myTransactionsButton: UIButton!
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("yes", forKey: "isLoggedIn")
        UserDefaults.standard.set("customer", forKey: "role")
        
        profileImageView.layer.cornerRadius = 25
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        self.db.collection("user_profile_image_urls").document(UserDefaults.standard.string(forKey: "userId")!).getDocument { (docSnapshot, error) in
            if error != nil {
                //do something
                print(error)
            } else {
                if let doc = docSnapshot {
                    let data = doc.data()
                    if let data = data {
                        let profileImageURL = data["imageURL"] as? String
                        UserDefaults.standard.set(profileImageURL, forKey: "profileImageURL")
                        self.profileImageView.sd_setImage(with: URL(string: profileImageURL!),
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
        
        scanQRAndPayButton.layer.cornerRadius = 20
        contactlessPayButton.layer.cornerRadius = 20
        myTransactionsButton.layer.cornerRadius = 20
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(panGesture)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHome),
                                               name: NSNotification.Name("ShowHome"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showBankAccounts),
                                               name: NSNotification.Name("ShowBankAccounts"),
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
        
        //        let userId = UserDefaults.standard.string(forKey: "userId")!
        //        let url = "https://paye-backend-adminpanel.herokuapp.com/api/users/customer/get/\(userId)"
        //        let header : HTTPHeaders = [
        //            "Authorization": UserDefaults.standard.string(forKey: "token")!
        //        ]
        //        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
        //            if let data = response.data {
        //                let json = try! JSON(data: data)
        //                print(json)
        //                self.nameLabel.text = json["result"][0]["name"].string
        //            }
        //            switch response.result {
        //            case .success(_):
        //                print("success")
        //                break
        //            case .failure(let error):
        //                print(error)
        //                break
        //            }
        //        }
    }
    
    @objc func showHome() {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func showBankAccounts() {
        performSegue(withIdentifier: "showBankAccounts", sender: nil)
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
    
    @IBAction func menuButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func viewTapped(gestureRecogniser : UIPanGestureRecognizer) {
        sideMenuOpen = false
        sideMenuConstraint.constant = -278
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
