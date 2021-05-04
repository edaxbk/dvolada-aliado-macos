//
//  User.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 14/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
