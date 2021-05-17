//
//  Store.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class Store : Decodable , Encodable{
    
    var name: String?
    
    var url_logo: String?
    
    var _id: String?
    
    var type: String?
    
    var score: Int?
    
    var state : String?
    
    var banner: String?
        
    var date_subscription: String?
    
    var counter: Int?
    
    var schedule: Array<Schedule>?
    
    var direction: String?
    
    lazy var scheduleDiff: Int = 1
    
    var location: LatLng?
    
    init() {
        self.scheduleDiff = 1
    }
    
    
}


class StoreResponse: Decodable, Encodable {
    
    var result: Store?
    
}

