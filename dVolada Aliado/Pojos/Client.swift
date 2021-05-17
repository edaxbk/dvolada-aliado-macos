//
//  Client.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 19/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class Client : Decodable , Encodable {
    
    var _id: String?
    
    var email: String?
    
    var phone_number: String?
    
    var profilePicture: String?
    
    var score: Double?
    
    var status_verification: String?
    
    var complete_name: String?
    
    var first_name: String?
        
    var openpay_id: String?
    
    var uid: String?
    
    var directionToSend: Direction?
    
}


class SMSVerificationNumber : Decodable, Encodable {
    
    var phone_number : String
    
    init(_ phoneNumber : String) {
        phone_number = phoneNumber
    }
    
    
}

class VerifyCodeBody : Codable {
    
    var code : String
    var token : String
    var type = "client"
    
    
    init(code : String , token : String) {
        
        self.code = code
        self.token = token
        
    }
    
}

class CodeResponse: Decodable {
    var client : Client
    var success : Bool
}


class RegisterClientResponse : Decodable , Encodable {
    
    var _id : String?
    var client : Client?
    var token : String?
    
}



class BodyDirection: Decodable, Encodable {
    
    var direction: Direction?
    var client_id: String?
    
}


class BooleanResponse : Decodable, Encodable {
    
     var success : Bool?
    
}
