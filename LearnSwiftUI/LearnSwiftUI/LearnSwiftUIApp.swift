//
//  LearnSwiftUIApp.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) private var appDelegate
    let persistentController  = PersistentController.shared
    
    @State var name: String = ""
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
                .environmentObject(CategoryViewModel.shared)
                .onOpenURL(perform: { url in
                    name = url.valueOf("name") ?? ""
                                        
                    print(url.absoluteURL)
                    print(name)
                })
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                print("App State : Background")
                persistentController.saveContext()
            case .inactive:
                print("App State : Inactive")
            case .active:
                print("App State : Active")
            @unknown default:
                print("App State : Unknown")
            }
        }
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
