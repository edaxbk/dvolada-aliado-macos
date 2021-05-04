//
//  Conductor.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 19/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class Conductor: Decodable, Encodable {

    var firstName: String?
    var profilePicture : String?
    var last_location: LatLng?
    var id: String?
    var _id: String?
    
    init() {
        
    }
}
