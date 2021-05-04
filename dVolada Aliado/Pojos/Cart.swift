//
//  Cart.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 19/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation

class Cart : Decodable, Encodable {
    var dish : Dish?
    var quantity : Int?
    var observation : String?
    
    init() {}
    
}
