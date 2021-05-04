//
//  Direction.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 19/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation

class Direction  : Decodable , Encodable{
    
    var place_id: String?

    var direction: String?
    
    var type : Int?

    var coordinates: LatLng?

    var floor: String?

    var building_name: String?

    var label: String?
 
    var delivery_note: String?
    
}



class DirectionResponse : Decodable , Encodable{
    var result : Array<Direction>?
}
