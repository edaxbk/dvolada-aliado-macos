//
//  ExtensionDate.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 04/06/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
