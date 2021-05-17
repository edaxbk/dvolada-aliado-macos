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
protocol AddTableViewCellDelegate: class {
    func didPressButtonAdd(sender: UIButton)
    func didPressButtonEdit(sender: UIButton)
}

protocol OrderInvitationListener {
    
    func onOrderAccepted()
    func onOrderRejected()
    
}
protocol DirectionsListener {
    func onDirectionSaved(direction : Direction)
}
protocol ClientDataListener {
    func onClientSaved(client : Client)
}

protocol HeaderListener {
    func onLogoPressed()
}


protocol TimeListener {
    func onTimeListener(timeEstimate : String)
}

protocol InputListener {
    func onEditTextChanged (text : String)
}


protocol OrderListener {
    func onOrderSelected(order : Order , position : Int)
    func onForceUpdate()
}

protocol CartUpdateProtocol {
    func onProductUpdate(position : Int , cartProduct : Cart)
    func onProductDelete(position : Int)
}

protocol CartEditListener {
    func onProductRequestChange(position : Int)
}


protocol IncrementalListener {
    func onQuantityUpdate(quantity : Int)
}

protocol CartListener {
    func onItemAdded(cart : Cart)
}

protocol DishListener {
    
    func onDishSelected(dish : Dish)
    
}

protocol GeneralCartListener {
    func onListUpdate (cart : Array<Cart>)
}

protocol TransactionListener {
    func onTransactionSuccess(transaction : Order)
}

protocol ModifierListener {
    func onUpdateList (list : Array<Options>)
}


protocol ModifierAddListener {
    func onModifierSelected(modifier: Modifier)
}
