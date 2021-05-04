//
//  DirectionGoogleResponse.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 01/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation

class DirectionGoogleResponse : Decodable, Encodable {
    var results: Array<DirectionMetaData>?

    init() {
        
    }
    
}

class DirectionMetaData  : Decodable, Encodable {
    
    var formatted_address : String?
    var place_id : String?
    
    init() {}
}
