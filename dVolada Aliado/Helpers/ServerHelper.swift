//
//  ServerHelper.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation
import Alamofire

/*    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try! encoder.encode(data)
    print(String(data: data, encoding: .utf8)!)
*/


class ServerHelper {
    
    
    static let shared = ServerHelper()
    init(){}
    
    
    func getDirections(clientId : String , onCompletion : @escaping (_ list : Array<Direction>) -> Void){
        
        let url = "\(BASE_URL)/client/direction/\(clientId)"
        
        print(url)
        
        AF.request(url, method: .post).responseDecodable(of: DirectionResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value!.result != nil){
                        onCompletion(response.value!.result!)
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func findAddress (latitude : Double, longitude : Double, onCompletion : @escaping (_ direction : Direction) -> Void){
        
        let url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=AIzaSyBEVFfED18HIbgjd3behPizz5YAZHEbXzA"
        
    

        AF.request(url).responseDecodable(of: DirectionGoogleResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value!.results != nil){
                        let results = response.value!.results!
                        
                        if (results.count > 0) {
                            let direction = Direction()
                            
                            direction.coordinates = LatLng(latitude: latitude, longitude: longitude)
                            direction.direction = results[0].formatted_address
                            direction.place_id = results[0].place_id
                            onCompletion(direction)
                        }
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    func login(email : String , password : String, onCompletion : @escaping (_ store : Store) -> Void, onFailure: @escaping (_ error : AFError) -> Void ){
        
        let url = "\(BASE_URL)/store/login"
        
        let loginBody = LoginBody()
        loginBody.email = email
        loginBody.password = password
        loginBody.isFromMobile = true
        
        
        AF.request(url , method: .post , parameters: loginBody).validate().responseDecodable(of: StoreResponse.self) { response in
            
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value?.result != nil){
                        onCompletion(response.value!.result!)
                    }
                }
            case let .failure(error):
                onFailure(error);
            }
        }
    }
    
    func getStoreById(id : String , onCompletion : @escaping (_ store : Store) -> Void, onFailure: @escaping (_ error : AFError) -> Void ){
        
        let url = "\(BASE_URL)/store/\(id)/mobile"
        
        AF.request(url , method: .get ).validate().responseDecodable(of: StoreResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value?.result != nil){
                        onCompletion(response.value!.result!)
                    }
                }
            case let .failure(error):
                onFailure(error);
            }
        }
    }
    // MARK: POST modifierStore
    func postModifierFromStore( modifier: Modifier, store : Store ,onCompletion: @escaping (_ succes: Bool) -> Void, onFailure: @escaping (_ error : AFError) -> Void ){
        let url = "\(BASE_URL)/restaurant/modifier/"
        
        let bodyModifier = BodyModifier()
        bodyModifier.modifier = modifier
        bodyModifier.store = store
        
        AF.request(url , method: .post, parameters: bodyModifier , encoder: JSONParameterEncoder.default ).validate().responseDecodable(of: BooleanResponse.self) { response in
            
            switch response.result {
            case .success:
                onCompletion(true)
            case let .failure(error):
                onFailure(error)
            }
        }
    }
    
    
    // MARK: POST modifierStore
    func putModifierFromStore( id : String ,  modifier: Modifier,onCompletion: @escaping (_ succes: Bool) -> Void, onFailure: @escaping (_ error : AFError) -> Void ){
        let url = "\(BASE_URL)/modifier/\(id)"
    
        let encoder = JSONEncoder()
          encoder.outputFormatting = .prettyPrinted
          let data = try! encoder.encode(modifier)
          print(String(data: data, encoding: .utf8)!)        
        
        AF.request(url , method: .put, parameters: modifier , encoder: JSONParameterEncoder.default ).validate().responseDecodable(of: BooleanResponse.self) { response in
            
            switch response.result {
            case .success:
                onCompletion(true)
            case let .failure(error):
                onFailure(error)
            }
        }
    }
    
    
    // MARK: GET modifierStore
    func getModifiersStore(id : String , onCompletion : @escaping (_ list : Array<Modifier>) -> Void){
        let url = "\(BASE_URL)/restaurant/modifiers/\(id)"
        
        AF.request(url).responseDecodable(of: ModifierResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value!.result != nil){
                        onCompletion(response.value!.result!)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    // MARK: DELETE modifierStore
    func deleteModifiersStore(id : String , onCompletion : @escaping (_ succes: Bool) -> Void){
        let url = "\(BASE_URL)/restaurant/modifier/\(id)"
        
        AF.request(url, method: .delete).responseDecodable(of: BooleanResponse.self) { response in
            switch response.result {
            case .success:
                print("Category Delete")
                onCompletion(true)
            case let .failure(error):
                print(error)
            }
        }
    }
    // MARK: DELETE CategoryMenuStore
    func deleteCategoryMenuStore(id: String,onCompletion : @escaping (_ succes: Bool) -> Void) {
        let url = "\(BASE_URL)/restaurant/menu_category/\(id)"
        
        AF.request(url, method: .delete).validate().responseDecodable(of: BooleanResponse.self) { response in
            
            print("RESPONSE", response.result , "--", (response.response?.statusCode)!)
            
            switch response.result {
                
            case .success:
                print("Category Delete")
                onCompletion(true)
            case let .failure(error):
                print("Error in deleteCategoryMenu: ",error)
            }
        }
    }
    // MARK:GET menu store
    func getMenuFromStoreAll(id : String , onCompletion : @escaping (_ list : Array<Menu>) -> Void){
        let url = "\(BASE_URL)/store/menu_category/\(id)"
        
        AF.request(url).responseDecodable(of: MenuResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value!.result != nil){
                        onCompletion(response.value!.result!)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getMenuFromStore(id : String , onCompletion : @escaping (_ list : Array<Menu>) -> Void){
        let url = "\(BASE_URL)/restaurant/menu_category/\(id)"
        
        AF.request(url).responseDecodable(of: MenuResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value!.result != nil){
                        onCompletion(response.value!.result!)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    //POST menu store
    func postMenuFromStore(id: String, title: String ,onCompletion: @escaping (_ store : Menu) -> Void, onFailure: @escaping (_ error : AFError) -> Void ){
        let url = "\(BASE_URL)/store/menu_category/"
        
        let bodyMenu = Menu()
        bodyMenu.isAvailable = false
        bodyMenu.title = title
        bodyMenu.store = id
        
        AF.request(url,method: .post, parameters: bodyMenu ).validate().responseDecodable(of: Menu.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    onCompletion(response.value!)
                }
            case let .failure(error):
                print(error)
                onFailure(error)
            }
        }
    }
    //PUT isAvailable menuStore
    func putMenuFromStore(id:String,isAvailable: Bool){
        let url = "\(BASE_URL)/restaurant/menu_category/"
        
        let menuBody = Menu()
        menuBody._id = id
        menuBody.isAvailable = isAvailable

        AF.request(url ,method: .put, parameters: menuBody).validate().responseDecodable(of:BooleanResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value?.success != nil){
                        print("Succes::",(response.value?.success)!)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    //PUT dish
    func putDishFromMenu(dish: Dish, onCompletion: @escaping (_ store : BooleanResponse) -> Void ){
        
        let url = "\(BASE_URL)/restaurant/dish"

        print("::-..>>",dish)
        AF.request(url, method: .put, parameters: dish, encoder: JSONParameterEncoder.default).validate().responseDecodable(of:BooleanResponse.self) { response in
                print("DISH RESPONSE",response)
            switch response.result {
            case .success:
                onCompletion(response.value!)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //POST dish menu store
    func postDishMenuFromStore(id: String, menuId: String, dish: Dish ,onCompletion: @escaping (_ store : BooleanResponse) -> Void ){
        let url = "\(BASE_URL)/restaurant/dish"
        let dishBody = DishBody()
        dishBody.dish = dish
        dishBody.store = id
        dishBody.id_menu = menuId
        
        AF.request(url, method: .post, parameters: dishBody, encoder: JSONParameterEncoder.default).validate().responseDecodable(of:BooleanResponse.self) { response in
            switch response.result {
            case .success:
                onCompletion(response.value!)
            case let .failure(error):
                print(error)
            }
        }

    }
    
    //MARK:DELETE dish
    func deleteDishMenuFromStore(id: String ,onCompletion: @escaping (_ store : BooleanResponse) -> Void ) {
       
        let url = "\(BASE_URL)/restaurant/dish/\(id)"
        AF.request(url, method: .delete).validate().responseDecodable(of:BooleanResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value?.success != nil){
                        onCompletion(response.value!)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    //UPDATE Schedule Store
    func updateStoreSchedule(store: Store, success: @escaping (_ user: Store) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(BASE_URL)/super_user/store/\(store._id!)"
        
        AF.request(url, method: .put, parameters: store, encoder: JSONParameterEncoder.default).responseDecodable (of: StoreResponse.self) {  response in
            
            if let _ = response.value, store._id != nil {
                success(store)
            } else {
                failure(response.error)
            }
        }
    }
    //------------------------------
    func updateStatusOnTransaction(transaction: Order, onCompletion : @escaping () -> Void,onError : @escaping () -> Void) {
        
        let url = "\(BASE_URL)/transaction"
        
        AF.request(url , method: .put , parameters: transaction).responseDecodable(of: BooleanResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value?.success != nil){
                        onCompletion()
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    //MARK: GET FEE COST

    func getFeeCost(locationStore : LatLng, destination : LatLng, state : String, onSuccess : @escaping (_ priceFee: PriceFee) -> Void){
        
        let url = "\(BASE_URL)/client/fee/\(locationStore.latitude!)/\(locationStore.longitude!)/\(destination.latitude!)/\(destination.longitude!)/\(state)"
        
        AF.request(url).responseDecodable(of: PriceFeeResponse.self) { response in
            switch response.result {
            case .success:
                if(response.value != nil){
                    if(response.value!.result != nil){
                        onSuccess(response.value!.result!)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK: POST CREAR ORDER
    
    func createOrder(order : Order, onCompletion : @escaping (_ data : TransactionResponse) -> Void){
        
    
        let url = "\(BASE_URL)/transaction"
        
        let session = URLSession.shared

           //now create the URLRequest object using the url object
           var request = URLRequest(url: URL(string: url)!)
           request.httpMethod = "POST" //set http method as POST

           do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.dict!, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
           } catch let error {
               print(error.localizedDescription)
           }

           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")

           //create dataTask using the session object to send data to the server
           let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

               guard error == nil else {
                   return
               }

               guard let data = data else {
                   return
               }

               do {
                   //create json object from data
                   if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    
                    let transactionResponse = TransactionResponse()
                    
                    transactionResponse._id = json["_id"] as! String?
                    
                    onCompletion(transactionResponse)
                       // handle json...
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
           })
           task.resume()
        
        
    }
    
}
