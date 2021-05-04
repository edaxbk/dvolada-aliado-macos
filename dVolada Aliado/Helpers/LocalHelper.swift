//
//  LocalHelper.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation


class LocalHelper {
    
    static let shared = LocalHelper()
    init(){}
    
    public func setClient(_ client : Store?){
        if(client == nil){
            UserDefaults.standard.set(nil, forKey: "client")
        }else{
            UserDefaults.standard.set(try! PropertyListEncoder().encode(client), forKey: "client")
        }
        
    }
    
    public func getClient() -> Store? {
        
        let storedObject: Data? = UserDefaults.standard.object(forKey: "client") as? Data
        
        if storedObject != nil{
            let storedPlayer: Store? = try? PropertyListDecoder().decode(Store.self, from: storedObject!)
            return storedPlayer
        }
        
        
        return nil
    }
}
