//
//  BodyLogin.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class LoginBody : Decodable, Encodable {
    
    var email : String?
    var password : String?
    var isFromMobile : Bool?
    
    
    
}
