//
//  NotificationManager.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 2/22/22.
//

import Foundation
import UserNotifications

enum NotificationManagerConstants {
  static let calendarBasedNotificationThreadId =
    "CalendarBasedNotificationThreadId"
}

class NotificationManager: ObservableObject {
  static let shared = NotificationManager()
  @Published var settings: UNNotificationSettings?

  func requestAuthorization(completion: @escaping  (Bool) -> Void) {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
          completion(granted)
          if !granted {
              print("something went wrong")
          } else {
              self.fetchNotificationSettings()
          }
      }
  }
    
    func fetchNotificationSettings() {
      // 1
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        // 2
        DispatchQueue.main.async {
          self.settings = settings
        }
      }
    }

  func removeScheduledNotification(task: TaskDB) {
      if let id = task.id {
          UNUserNotificationCenter.current()
                .removePendingNotificationRequests(withIdentifiers: [id])
      }
  }

  // 1
  func scheduleNotification(task: TaskDB) {
    // 2
    let content = UNMutableNotificationContent()
    content.title = task.taskName ?? ""
    content.body = "Gentle reminder for your task!"
    content.categoryIdentifier = "LearnSwiftUI"

    // 3
    var trigger: UNNotificationTrigger?
      if let date = task.taskDate {
        trigger = UNCalendarNotificationTrigger(
          dateMatching: Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute],
            from: date),
          repeats: false)
      }
      content.threadIdentifier =
        NotificationManagerConstants.calendarBasedNotificationThreadId
    // 4
    if let trigger = trigger {
      let request = UNNotificationRequest(
        identifier: task.id!,
        content: content,
        trigger: trigger)
      // 5
      UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
          print(error)
        }
      }
    }
  }
}
