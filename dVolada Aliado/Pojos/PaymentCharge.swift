//
//  PaymentCharge.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 19/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class PaymentCharge : Decodable , Encodable {
    
    
    let CASH = "CASH"
    let CARD = "CARD"
    
    var total: Double?
    var subTotal: Double?
    var typeOfPayment: String?
    var fee: Int?
    var cashClient: Int?
    var device_session_id: String?
    var source_id: String?
    var cvv2: String?
    var discount: Double?
    
    init() {
        discount = 0.0
    }
}
