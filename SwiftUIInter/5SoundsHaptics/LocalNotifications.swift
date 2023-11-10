//
//  Notifications.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error! \(error.localizedDescription)")
            } else {
                print("Success!")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is notification!"
        content.subtitle = "Subtitle"
        content.sound = .default
        content.badge = 1
        
        // 3 types of triggers
        
        // time
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 17
        dateComponents.minute = 29
        dateComponents.weekday = 6 // every friday at 17:29
        
        let triggerCalendar = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 51.246040,
            longitude: 22.533680)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 50, // radius in metres (e.g. coffee shop)
            identifier: UUID().uuidString)
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        let triggerLocation = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, 
            content: content,
            trigger: triggerLocation)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotifications: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            .buttonStyle(.bordered)
            
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            .buttonStyle(.bordered)
            
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotification()
            }
            .buttonStyle(.bordered)
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    LocalNotifications()
}
