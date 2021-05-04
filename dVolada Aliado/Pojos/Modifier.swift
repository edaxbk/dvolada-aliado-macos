//
//  Modifier.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 19/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class Modifier : Decodable , Encodable{
    
    var _id: String?
    
    var title: String?
    
    var option_selection_length: Int?
    
    var options: Array<Options>?
    
    var optionsSelected: Array<Options>?
    
    var isVisible: Bool?
    
    var isOptional: Bool?
    
}


class ModifierResponse : Decodable , Encodable {
    
    var result: Array<Modifier>?
    
}


class Options  : Decodable , Encodable {
    var name: String?
    var _id: String?
    var fee: Int?
    var isSelected: Bool?
}


class BodyDish  : Decodable , Encodable{
    var dish: Dish?
    var client_id: String?
}


class DishResponse : Encodable, Decodable{
    var result: Array<Dish>?
}

class BodyModifier  : Decodable , Encodable{
    var modifier: Modifier?
    var store: Store?
}


