//
//  Menu.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 28/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class Menu: Decodable , Encodable{
    
    var _id : String?
        
    var title: String?
   
    var isAvailable: Bool?
    
    var store: String?

    var menu : Array<Dish>?
}

class MenuResponse : Decodable , Encodable {
    
    var result: Array<Menu>?
    
}
