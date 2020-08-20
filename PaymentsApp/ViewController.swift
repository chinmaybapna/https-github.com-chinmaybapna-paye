//
//  ViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 23/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let splashImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "splashImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    var bottomAnchor: NSLayoutConstraint?
    var leftAnchor: NSLayoutConstraint?
    var rightAnchor: NSLayoutConstraint?
    var heightAnchor: NSLayoutConstraint?
    var topAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoImageView.isHidden = true
        
        view.addSubview(splashImageView)
        
        leftAnchor = splashImageView.leftAnchor.constraint(equalTo: view.leftAnchor)
        leftAnchor?.isActive = true
        
        rightAnchor = splashImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        rightAnchor?.isActive = true
       
        topAnchor = splashImageView.topAnchor.constraint(equalTo: view.topAnchor)
        topAnchor?.isActive = true
        
        bottomAnchor = splashImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomAnchor?.isActive = true
        
        //splashImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        //heightAnchor = splashImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        //heightAnchor?.isActive = true
        
        self.handleAnimation()
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.performSegue(withIdentifier: "splash_screen_over", sender: nil)
        }
//
//        UIView.animate(withDuration: 1, delay: 0.5, animations: {
//            self.logoImageView.transform = CGAffineTransform(scaleX: 23.8, y: 23.8)
//        }) { (true) in
//
//        }
    }
    
    func handleAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.topAnchor?.isActive = false
            self.heightAnchor =  self.splashImageView.heightAnchor.constraint(equalToConstant: 200)
            self.heightAnchor?.isActive = true
            self.splashImageView.contentMode = .top
            self.view.layoutIfNeeded()
        }, completion: { (true) in
            self.logoImageView.isHidden = false
        })
        
    }
}

