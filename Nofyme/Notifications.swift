//
//  Notifications.swift
//  Nofyme
//
//  Created by s b on 17.08.2022.
//

import UserNotifications
import CoreLocation

class Notifications {
    func addNotification(atTime: Date? = nil, atLocation: CLLocation? = nil, name: String, desc: String?) {
        //TODO: User defaults on asking to notify
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        let content = UNMutableNotificationContent()
        content.title = name
        content.subtitle = desc ?? ""
        content.sound = UNNotificationSound.default
        
        var trigger: UNNotificationTrigger!
        
        if let timeIntervalSinceNow = atTime?.timeIntervalSinceNow {
        
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalSinceNow, repeats: false)
        }
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
