//
//  Home.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/4/22.
//

import SwiftUI

struct Home: View {
    @Binding var selectedTab: String
    
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    //All tab in side menu
    var body: some View {
        TabView(selection: $selectedTab) {
            //Views
            HomePageView().tag("Home")
            
            TemplatesPageView().tag("Templates")
            
            CategoriesPageView().tag("Categories")
            
            AnalyticsPageView().tag("Analytics")
            
            SettingsPageView().tag("Settings")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
