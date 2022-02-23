//
//  MyAppDelegate.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/10/22.
//

import UIKit

class MyAppDelegate: UIResponder, UIApplicationDelegate {
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.configureUserNotifications()
        if let directoryLocation = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print("Documents Directory: \(directoryLocation)Application Support")         }
        return true
    }
}


// MARK: - UNUserNotificationCenterDelegate
extension MyAppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler(.banner)
  }

  private func configureUserNotifications() {
    UNUserNotificationCenter.current().delegate = self
    // 1
    let dismissAction = UNNotificationAction(
      identifier: "dismiss",
      title: "Dismiss",
      options: []
    )
    // 2
    let category = UNNotificationCategory(
      identifier: "LearnSwiftUI",
      actions: [dismissAction],
      intentIdentifiers: [],
      options: []
    )
    // 3
    UNUserNotificationCenter.current().setNotificationCategories([category])
  }

  // 1
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    completionHandler()
  }
}
