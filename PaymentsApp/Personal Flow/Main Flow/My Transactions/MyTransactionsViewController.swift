//
//  MyTransactionsViewController.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 26/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class MyTransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewForTableView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var splashImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TransactionsTableViewCell", bundle: nil), forCellReuseIdentifier: "transactions_cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = #colorLiteral(red: 0.4807969332, green: 0.78446877, blue: 0.07518606633, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.9350233674, green: 0.9904155135, blue: 0.9587365985, alpha: 1)
        
        headerView.layer.cornerRadius = 40
        headerViewForTableView.layer.cornerRadius = 40
        
        //splashImage.alpha = 0.6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactions_cell", for: indexPath) as! TransactionsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
