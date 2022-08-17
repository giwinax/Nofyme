//
//  Notifications.swift
//  Nofyme
//
//  Created by s b on 17.08.2022.
//

import UserNotifications

class Notifications {
    func addNotification(at: Date, name: String, desc: String?) {
        
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
        
        let timeIntervalSinceNow = at.timeIntervalSinceNow
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalSinceNow, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
