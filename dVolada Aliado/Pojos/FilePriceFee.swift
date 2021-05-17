//
//  FilePriceFee.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 11/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation

class PriceFee : Decodable, Encodable{
    var price: Double?
    var extraFee: Double?
    var km: String?
    var time: String?
    var polyLine: String?
    var isRain: Bool?
}

class PriceFeeResponse : Decodable, Encodable{
    var result: PriceFee?
}
