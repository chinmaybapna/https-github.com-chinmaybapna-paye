//
//  CustomerModal.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 01/08/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import Foundation

struct CustomerModal: Codable {
    var name : String
    var email : String
    var role : String = "customer"
    var phone : String
    var pin : String
    var details : [Details]
}

struct Details: Codable {
    var dateOfBirth : String
    var email : String
}
