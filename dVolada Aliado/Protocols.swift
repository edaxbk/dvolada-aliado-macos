//
//  Protocols.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 22/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit
//Protocolo para presionar un add en un mofigicador

protocol OrderInvitationListener {
    
    func onOrderAccepted()
    func onOrderRejected()
    
}
protocol DirectionsListener {
    func onDirectionSaved(direction : Direction)
}

protocol HeaderListener {
    func onLogoPressed()
}


protocol TimeListener {
    func onTimeListener(timeEstimate : String)
}



protocol OrderListener {
    func onOrderSelected(order : Order , position : Int)
    func onForceUpdate()
}
