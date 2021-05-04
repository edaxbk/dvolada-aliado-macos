//
//  Order.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import Foundation

class Order : Decodable, Encodable {
    
    var _id: String?
    
    var client: Client?
    
    var date_mobile: String?
    
    var cart: Array<Cart>?
    
    var store: Store?
    
    var status: String?
    
    var paymentCharge: PaymentCharge?
    
    var time_arrived_conductor: String?
    
    var time_distance_aprox: String?
    
    var conductor: Conductor?
    
    var fee : Int?
    
    var destination: LatLng?
    
    var conductor_last_location: LatLng?
    
    var direction_destination: String?
 
    var estimatedTime: String?
   
    

}

class TransactionResponse : Decodable, Encodable {
    
    
    var _id : String?
    
    init() {}
    
}


class TransactionListResponse : Decodable , Encodable {

    var result: Array<Order>?
    
    init() {
        
    }
    

    
}


class TransactionPeople : Decodable , Encodable{
    
    init() {

    }
    
    var _id: String?
    var store: Store?
    var conductor: Conductor?
    var client: Client?
    //var message: MessageUser?
    
}
