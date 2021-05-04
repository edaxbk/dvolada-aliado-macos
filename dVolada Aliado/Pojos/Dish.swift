//
//  Dish.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 19/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class Dish : Decodable , Encodable{
    
    var _id: String?
    
    var id_restaurant: String?
    
    var title: String?
    
    var description: String?
    
    var price: Int?
    
    var images: Array<String>?
    
    var store: Store?
    
    var isAvailable: Bool?
    
    var originalPrice: Int?
    
    var modifiers : Array<Modifier>?
    
    var row: Int?
    
}


extension Encodable {

    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}

class DishBody : Decodable , Encodable{
    
    var store : String?
    var id_menu : String?
    var dish: Dish?
    
}
