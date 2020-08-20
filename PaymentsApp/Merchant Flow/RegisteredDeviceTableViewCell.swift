//
//  RegisteredDeviceTableViewCell.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 29/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit

class RegisteredDeviceTableViewCell: UITableViewCell {

    var isCheckBoxChecked = false
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCheckMark))
        checkBoxImageView.isUserInteractionEnabled = true
        checkBoxImageView.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func showCheckMark(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if !isCheckBoxChecked {
            isCheckBoxChecked = true
            tappedImage.image = #imageLiteral(resourceName: "ticked_checkbox")
        } else {
            isCheckBoxChecked = false
            tappedImage.image = #imageLiteral(resourceName: "checkBox")
        }
    }
    
}
