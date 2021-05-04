//
//  LatLng.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class LatLng  : Decodable , Encodable {
    
    var latitude : Double?
    var longitude : Double?
    
    init(latitude : Double , longitude : Double) {
        
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
