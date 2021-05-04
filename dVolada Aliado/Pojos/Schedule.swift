//
//  Schedule.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 25/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

import Foundation

class Schedule: Decodable, Encodable {
    
    var hourStart: String?
    var hourEnd: String?
    var isAvailable: Bool?
 
    init() {
        
    }
    
}
