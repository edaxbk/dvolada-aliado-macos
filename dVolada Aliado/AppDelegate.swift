//
//  AppDelegate.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import GooglePlaces

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        registerForPushNotifications()
        
        GMSServices.provideAPIKey("AIzaSyBEVFfED18HIbgjd3behPizz5YAZHEbXzA")
        GMSPlacesClient.provideAPIKey("AIzaSyBEVFfED18HIbgjd3behPizz5YAZHEbXzA")
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func registerForPushNotifications() {
        
//        UNUserNotificationCenter.current().delegate = self
//        Messaging.messaging().delegate = self
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//            (granted, error) in
//            print("Permission granted: \(granted)")
//
//            guard granted else { return }
//
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//
//            InstanceID.instanceID().instanceID { (result, error) in
//                if let error = error {
//                    print("Error fetching remote instance ID: \(error)")
//                } else if let result = result {
//                    print("Remote instance ID token: \(result.token)")
//
//                    FirebaseAPI.shared.updateToken(token: result.token)
//
//                }
//            }
//        }
    }
    
}

