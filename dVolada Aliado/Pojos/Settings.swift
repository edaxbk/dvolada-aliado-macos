//
//  Settings.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation



class Settings : Decodable, Encodable{
    
    var basePrice: Double?
    var priceKilometer: Double?
    var maxDistance: Int?
    var minDistance: Double?
    var minCost: Int?
    var showHelpButton : Bool?
    
}
