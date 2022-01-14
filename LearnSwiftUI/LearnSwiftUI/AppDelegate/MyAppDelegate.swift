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
        if let directoryLocation = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print("Documents Directory: \(directoryLocation)Application Support")         }
        return true
    }
}
