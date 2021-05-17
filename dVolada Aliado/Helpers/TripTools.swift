//
//  TripTools.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation

class TripTools {
    
    public func calculateTrip(settings: Settings, distanceFromReference: Double) -> Double{
        var finalPrice = settings.priceKilometer! * (distanceFromReference) + settings.basePrice!
        
        if (Int(distanceFromReference) <= Int(settings.minDistance!)) {
            finalPrice = Double(settings.minCost!)
        }
        
        return finalPrice
    }
    
    public func checkIfStoreIsOpen(store : Store) -> Bool{
        
        if(store.schedule != nil){
            
            var isAvailable = true
            
            var schedule = store.schedule![getDayOftheWeek()]
            
            if(schedule.isAvailable != nil){
                isAvailable = schedule.isAvailable!
            }
            
            if let open = Time.create(time: schedule.hourStart!), let close = Time.create(time: schedule.hourEnd!) {
                return Time.isOpen(open: open, close: close) && isAvailable
            }
            
        }
        
        return false
    }
    
    public func getDayOftheWeek() -> Int{
        let day = NSDate().dayOfTheWeek()
        
        print("TODAY IS \(day)")
        
        switch (day) {
            
        case "Monday" :
            return 0
            
            
        case "Tuesday" :
            return 1
            
            
        case  "Wednesday" :
            return 2
            
            
        case "Thursday" :
            return 3
            
        case "Friday" :
            return 4
            
        case  "Saturday" :
            return 5
            
            
        case "Sunday" :
            return 6
            
        default:
            break
        }
        
        return 0
    }
    
}


extension NSDate {
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date)
    }
}



struct Time: Comparable {
    var hour = 0
    var minute = 0

    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    init(_ date: Date) {
        let calendar = Calendar.current
        hour = calendar.component(.hour, from: date)
        minute = calendar.component(.minute, from: date)
    }

    static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.hour == rhs.hour && lhs.minute == rhs.minute
    }

    static func < (lhs: Time, rhs: Time) -> Bool {
        return (lhs.hour < rhs.hour) || (lhs.hour == rhs.hour && lhs.minute < rhs.minute)
    }

    static func create(time: String) -> Time? {
        let parts = time.split(separator: ":")
        if let hour = Int(parts[0]), let minute = Int(parts[1]) {
            return Time(hour: hour, minute: minute)
        }
        return nil
    }

    static func isOpen(open: Time, close: Time) -> Bool {
        let isClosingAfterMidnight = close.hour < open.hour ? true : false
        let currentTime = Time(Date())

        if isClosingAfterMidnight {
            return currentTime > close && currentTime < open ? false : true
        }
        return currentTime >= open && currentTime < close
    }
}
