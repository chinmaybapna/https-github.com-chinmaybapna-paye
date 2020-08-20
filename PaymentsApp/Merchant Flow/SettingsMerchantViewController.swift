//
//  SettingsMerchantViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 07/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import SDWebImage

class SettingsMerchantViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.layer.cornerRadius = 25
        
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
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name")!
    }
    
    @IBAction func editButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        let nameAction = UIAlertAction(title: "Change Name", style: .default) { (action) in
            //do something
            let alert = UIAlertController(title: "Great Title", message: "Please input something", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { (alertAction) in
                let textField = alert.textFields![0] as UITextField
                if let changedName = textField.text {
                    self.updateNameInBackend(name: changedName)
                    self.nameLabel.text = changedName
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Enter your name"
            }
            
            alert.addAction(action)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        actionSheet.addAction(nameAction)
        let photoAction = UIAlertAction(title: "Change Profile Image", style: .default, handler: { (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        })
        actionSheet.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        actionSheet.view.backgroundColor = #colorLiteral(red: 0.8423798084, green: 1, blue: 0.8301133513, alpha: 1)
        actionSheet.view.tintColor = #colorLiteral(red: 0.275267005, green: 0.482419312, blue: 0, alpha: 1)
        actionSheet.view.layer.cornerRadius = 0.5 * actionSheet.view.bounds.size.width
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImageView.image = image
        var imageURLString : String?
        if let imageData = profileImageView.image?.jpegData(compressionQuality: 0.25) {
            print(imageData)
            print( UserDefaults.standard.string(forKey: "userId")!)
            let imageRef = storageRef.child("\(String(describing: UserDefaults.standard.string(forKey: "userId")!)).jpg")
            print(imageRef)
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                imageRef.downloadURL { (url, error) in
                    if error != nil {
                        print(error!)
                    }

                    if let url = url {
                        imageURLString = "\(url)"
                        print(imageURLString!)
                        UserDefaults.standard.set(imageURLString, forKey: "profileImageURL")
                    
                        self.db.collection("user_profile_image_urls").document(UserDefaults.standard.string(forKey: "userId")!).setData([
                            "imageURL": imageURLString!
                        ]) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            }
                        }
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func updateNameInBackend(name: String) {
        let userId = UserDefaults.standard.string(forKey: "userId")!
        let url = "https://paye-backend-adminpanel.herokuapp.com/api/users/merchant/update/\(userId)"
        let header : HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
        let parameters : [String: Any] = [
            "pin": UserDefaults.standard.string(forKey: "pin")!,
            "name": name
        ]
        AF.request(URL(string: url)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(_):
                print("success")
                UserDefaults.standard.set(name, forKey: "name")
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
