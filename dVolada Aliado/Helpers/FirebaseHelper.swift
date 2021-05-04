//
//  FirebaseHelper.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CodableFirebase


class FirebaseAPI {
    let storage = Storage.storage().reference()
    let metadata = StorageMetadata()

    var ref: DatabaseReference!
    static let shared = FirebaseAPI()
    
    func getCurrentTrips(_id: String, onCompletion : @escaping (_ list: Array<Order>) -> Void) {
        
        Database.database()
            .reference(withPath : "stores")
            .child(_id)
            .child("trips_saved")
            .observeSingleEvent(of: .value) { (snapshot) in
                if(snapshot.exists()){
                    var list = Array<Order>()
                    
                    for rest in snapshot.children.allObjects as! [DataSnapshot] {
                        let value = rest.value as? NSDictionary
                        if(value!["data"] != nil){
                            let jsonData = value!["data"] as! String
                            let data = jsonData.data(using: .utf8)!
                            
                            do {
                                let order = try JSONDecoder().decode(Order.self, from: data)
                                order.status = value!["status"] as! String
                                list.append(order)
                            } catch {
                                print(error)
                            }
                        }
                        
                    }
                    
                    onCompletion(list)
                }
            }
    }
    
    
    
    
    func listenToTrips(_id: String, onNewTransaction : @escaping (_ order : Order) -> Void){
        
        Database.database()
            .reference(withPath : "stores")
            .child(_id)
            .child("trips")
            .observe(.childAdded) { (snapshot) in
        
                let value = snapshot.value as? NSDictionary
                let jsonData = value!["data"] as! String
                let data = jsonData.data(using: .utf8)!
                
                do {
                    let order = try JSONDecoder().decode(Order.self, from: data)
                    order.status = "STORE_PENDING"
                    onNewTransaction(order)
                } catch {
                    print(error)
                }
            }
    }
    
    func checkIfStatusHasChanged(_id: String,   onUpdate : @escaping () -> Void){
        
        Database.database()
            .reference(withPath : "stores")
            .child(_id)
            .child("trips_saved")
            .observe(.childChanged) { (snapshot) in
                onUpdate()
            }
    }
    

}


